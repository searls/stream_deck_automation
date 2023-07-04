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

## generate_text

The `generate_text` script will generate text for a given context (e.g. "5th
grade essay", "Ruby code") provided a given prompt.  The prompt can come in via
either a CLI flag or STDIN. Additionally, the prompt can be retained in the
output and the generated text can be appended (`--append`) or prepended
(`--prepend`).

```
Usage: generate_text --prompt "a method to add two numbers" --context "Ruby code (without markdown codefences)"

    The above command will set the provided context and then send the prompt to
    OpenAI's Chat GPT-4 API and return something like "def(a,b); a + b; end" to
    STDOUT.

    Options:

    --prepend - Will prepend the result to the prompt instead of replacing it
    --append - Will append the result to the prompt instead of replacing it

    Example:

    $ generate_text --prompt "def add(a,b); a+b; end" --context "A code comment" --prepend
    # This function takes two inputs (a, b), adds them together, and returns the result.
    def add(a,b); a+b; end
```
