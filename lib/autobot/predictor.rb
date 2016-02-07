class Autobot::Predictor
  def initialize(target_key)
    @target_key = target_key
  end

  def train
    json = JSON.dump(model_data)
    File.write(Autobot.model_data_path(@target_key), json)
  end

  def predict_answer_to(question)
    input_vec = vectorize(question)
    return if input_vec.empty?

    valid_answers = model_data
      .sort_by { |data| Autobot::WordVec.new(data.first).similarity_to(input_vec) }
      .slice(-3..-1)

    valid_answers.sample.last if valid_answers
  end

  private

  def dataset
    @dataset ||= CSV.table(
      Autobot.conversation_data_path(@target_key),
      col_sep: "\t"
    )
  end

  def data_size
    @data_size ||= dataset.size
  end

  def df_table
    @df_table ||= dataset
      .map { |row| extract_morphemes_from(row[:question]).uniq }
      .reduce(Hash.new { |h, k| h[k] = 0 }) do |hash, morphemes|
        morphemes.each { |morpheme| hash[morpheme.base] += 1 }
        hash
      end
  end

  def idf_table
    @idf_table ||= df_table
      .reduce(Hash.new(Math.log(data_size))) do |hash, (key, val)|
        idf = Math.log(data_size / (val + 1).to_f)
        hash.merge!(key => idf)
      end
  end

  def extract_morphemes_from(sentence)
    Autobot::Sentence.new(sentence).morphemes.select do |morpheme|
      morpheme.inflectable? || morpheme.noun? && !morpheme.number?
    end
  end

  def model_data
    return @model_data if @model_data
    cache_path = Autobot.model_data_path(@target_key)

    @model_data =
      if File.exists?(cache_path)
        json = File.read(cache_path)
        JSON.load(json)
      else
        dataset.reduce([]) do |array, row|
          word_vec = vectorize(row[:question])
          array.push([word_vec.to_h, row[:answer]])
        end
      end
  end

  def vectorize(sentence)
    words = extract_morphemes_from(sentence).map(&:base)
    Autobot::WordVec.from_words(words: words, idf_table: idf_table)
  end
end
