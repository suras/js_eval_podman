class Result
  attr_reader :status, :result, :error

  def initialize(status:, result: nil, error: nil)
    @status = status
    @result = result
    @error = error
  end

  def success?
    status == :success
  end

  def self.success(result)
    new(status: :success, result: result)
  end

  def self.error(error)
    new(status: :error, error: error)
  end
end
