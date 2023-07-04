require_relative "request"

def transform(text:, prompt:)
  full_prompt = if prompt.empty?
    "Improve the following text:"
  elsif prompt.match?(/\p{Han}/)
    "下記、 #{prompt}:"
  else
    "For the following text, #{prompt}:"
  end
  request(messages: [
    {role: "system", content: full_prompt},
    {role: "system", content: text}
  ])
end
