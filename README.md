# Searls' AI Stream Deck Automations

I recently got a [Stream Deck XL](https://www.elgato.com/us/en/p/stream-deck-xl)
and decided I wanted to use it for general purpose productivity to assist
me in writing English, learning Japanese, and writing code instead.

Here's what the setup looks like:

![Blurry photo of my Stream Deck](https://github.com/searls/stream_deck_automation/assets/79303/5998080a-73ea-48d4-ad2e-53946671940c)

## Actions

Here's what each of the buttons above does, by column, left-to-right:

* Clipboard
  * `Paste -1` will paste whatever was in the clipboard before what's there now
  * `Paste -2` will paste the third-most recent item in the clipboard history
  * `Paste -3` will paste the fourth-most recent item in the clipboard history
  * `Paste -4` will paste the fifth-most recent item in the clipboard history
* Improve (each result pasted over the selected text)
  * `Grammar` improves the grammar of the selected text
  * `Formal` makes the selected text more formal
  * `Rephrase` rephrases the selected text
  * `Readable` makes the selected text easier to read
* Edit (results pasted over the selected text)
  * `Shorten` will (you guessed it) say what's selected in fewer words
  * `Punch Up` will make it punchier and snappier, like a marketer might
  * `Simplify` attempts to make the selection easier to understand
  * `Bullets` will rework the selection into a bullet-point list
* Translate (results pasted in-place)
  * `日本語` converts the selection to Japanese
  * `友達` rephrases selected Japanese to a more informal tone, appropriate for a close friend
  * `知り合い` rephrases selected Japanese to a polite tone, appropriate for an acquaintance
  * `会社員` rephrases selected Japanese to an honorific form, appropriate as a customer speaking by email to an employee
* Explain (results displayed in a pop-up)
  * `Meaning?` translates selected text into English
  * `Grammar?` explains grammar patterns present in the selection
  * `Pronounce?` generates a pronunciation guide for any kanji characters in the selection
  * `Context?` analyzes the selection for implied hierarchical relationships and contextual nuance
* Summarize (pop-up)
  * `Summary Sentence` summarizes the selection into a short sentence
  * `Summary Paragraph` summarizes the selection into a short paragraph
  * `Simplify` attempts to simplify the selection to be easier to understand
  * `Outline` creates an outline or bullets to summarize the selection
* Feedback (pop-up)
  * `Structure` gives feedback to improve the selected text's structure
  * `Naming` gives feedback to improve the selection's naming & word choice
  * `Design` gives feedback to improve the selection's design
  * `Error` makes suggestions on how to troubleshoot a selected error
* Home (no feedback)
  * `Fan On` turns on my ceiling fan
  * `Fan Off` turns off my ceiling fan
  * `Open Blinds` opens my office blinds
  * `Close Blinds` closes my office blinds

## Demos

Here's an example switching between different levels of formality in Japanese:
[translate.webm](https://github.com/searls/stream_deck_automation/assets/79303/b0b6c64c-d060-4062-92a6-59f882210287)

This was the result of `Summary Paragraph` after selecting [this article](http://arstechnica.com/science/2023/07/lonely-people-see-the-world-differently-according-to-their-brains/)'s text:
<img width="957" alt="Screenshot 2023-07-04 at 3 32 58 PM" src="https://github.com/searls/stream_deck_automation/assets/79303/518150b6-5b4d-4301-bd49-8a3394df5920">

Here's a screenshot of the pop-up generated when selecting [this script](/lib/generate.rb) and
asking for `Design` feedback:
<img width="1304" alt="design critique in VS Code" src="https://github.com/searls/stream_deck_automation/assets/79303/792f7e04-cd9f-47af-a5ca-5ff535479a19">

After selecting a build failure in slack and tapping the `Error` key:
<img width="1140" alt="Screenshot 2023-07-04 at 2 29 54 PM" src="https://github.com/searls/stream_deck_automation/assets/79303/73aa93df-871c-4930-8dff-c3ef02a85fc3">


## How to do this yourself

Here's how to use this as a starting point for doing something similar. Note
that the 4 macros in the rightmost column all reference shortcuts to my HomeKit
configuration, so those won't work for you.

To that end, this repository contains:

1. A  set of [Keyboard Maestro](https://www.keyboardmaestro.com/main/) macros,
which are each wired to one of the 32 buttons
2. A couple [Ruby scripts](/script) that invoke Open AI's GPT-4 model
3. A backup of my Stream Deck profile to restore from

### Importing the Macros

Install Keyboard Maestro, then [download this
repo](https://github.com/searls/stream_deck_automation/archive/refs/heads/main.zip)
and double click the file
[/keyboard_maestro/stream_deck.kmmacros](/keyboard_maestro/stream_deck.kmmacros)

You'll need to set up a few things for the macros to work:

1. A working Ruby 3.0 or higher environment that's enabled-by-default in your
shell (I use rbenv)
2. Put this repository's `/script` directory somewhere on your `PATH` (e.g.
`export PATH="$PATH:$HOME/code/searls/gpt_scripts/script"`)
3. In Keyboard Maestro's Variables preference pane:
    1. Create a variable named `ENV_PATH` and set it to the PATH to your Ruby
    environment and these scripts (you might consider pasting in the results of
    `echo $PATH` from your terminal)
    2. Create a variable named `ENV_PWD` that's set to your home directory (e.g.
    `/Users/justin`)

### Scripts

Running the scripts requires an [OpenAI API
key](https://openai.com/blog/openai-api) set to the ENV var `OPEN_AI_API_KEY`.

#### transform_text

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

#### generate_text

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
