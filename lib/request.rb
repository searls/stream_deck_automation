require_relative "http"

def request(messages:)
  return "No prompt provided" if messages.nil? || messages.empty?

  response = OpenAi::Http.post("chat/completions", {
    model: "gpt-4",
    max_tokens: 1000,
    messages: messages
  })

  if response.success?
    response.json.dig("choices", 0, "message", "content")
  else
    "Failed to make request: #{response.json.dig("error", "message")}"
  end
end
