require_relative "request"

def generate(context:, prompt:, mode:)
  full_context = if context.empty?
    "Generate text per the following:"
  elsif context.match?(/\p{Han}/)
    "#{context}を生成してください:"
  else
    "Please generate #{context} for the following:"
  end
  result = strip_codefences(request(messages: [
    {role: "system", content: full_context},
    {role: "system", content: prompt}
  ]))

  case mode
  when :replace
    result
  when :prepend
    "#{result}\n#{prompt}"
  when :append
    "#{prompt}\n#{result}"
  end
end

def strip_codefences(s)
  s.gsub(/^```\w*\n?/, "")
end
