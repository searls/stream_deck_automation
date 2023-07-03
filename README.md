# gpt_scripts

I am doing some productivity and home automation stuff that depends on making
API requests to ChatGPT. Requires an [OpenAI API key](https://openai.com/blog/openai-api)
set to the ENV var `OPEN_AI_API_KEY`.

# transform_text

The `transform_text` script will attempt to improve the provided text with a
specific focus on the given prompt. The prompt is optional (it'll just
generically "improve" what you provide it without one) and the text can come
in via either a CLI flag or STDIN

Usage:

```
Usage: transform_text --text "Hello, world!" --prompt "translate to Japanese"

The above command will send the prompt to OpenAI's Chat GPT-4 API and return
something like "こんにちは、世界！" to STDOUT.

If `--text` is not provided, the script will read from STDIN, so you can pipe
results. That manes something like:

transform_text --text "Hello, world!" --prompt "to Japanese" | transform_text -p "to English"

Will print something like "Hello, world!" to STDOUT.
```
