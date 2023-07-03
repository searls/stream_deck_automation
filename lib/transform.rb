require_relative "http"

def transform(text:, prompt:)
  response = OpenAi::Http.post("chat/completions", {
    model: "gpt-4",
    max_tokens: 1000,
    messages: [
      {role: "system", content: "Please improve the following message. #{"Specifically, #{prompt}:" if prompt}"},
      {role: "system", content: text}
    ]
  })

  if response.success?
    response.json.dig("choices", 0, "message", "content")
  else
    "Failed to make request: #{response.json.dig("error", "message")}"
  end
end
