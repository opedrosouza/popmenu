module RequestSpecHelper
  def json_body
    body = JSON.parse(response.body)
    body.is_a?(Hash) ? body.deep_symbolize_keys : body.map(&:deep_symbolize_keys)
  end
end
