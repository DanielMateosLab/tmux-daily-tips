# Tune copy-mode word selection with `word-separators`

In copy mode, tmux decides where a "word" starts and ends using the `word-separators` option. This controls double-click selection and the word motions (`w`, `b`, `e` in vi mode). The default is `" -_@"`, so a path like `/usr/local/bin/tool` or a name like `my_file-name` gets split into several pieces.

## Command

```sh
tmux set -g word-separators " "
```

Or in your config file:

```tmux
set -g word-separators " "
```

Setting it to a single space makes whitespace the only boundary, so a whole path or identifier is selected as one word.

## Example

Suppose your scrollback contains:

```
error: could not open /var/lib/my-app/cache_dir/index.db
```

With the default separators, double-clicking `index.db` selects only `index`, and pressing `w` moves through every `/`, `-`, and `_`. Add this to `~/.tmux.conf`:

```tmux
# Treat whitespace as the only word boundary in copy mode
set -g word-separators " "
```

Reload the config with `tmux source-file ~/.tmux.conf`. Now double-clicking `/var/lib/my-app/cache_dir/index.db` selects the entire path.

## Choosing a set

If you still want punctuation to split words in some cases, add only the characters you care about:

```tmux
# Split on whitespace, quotes, brackets, and "=" but keep paths and dashes intact
set -g word-separators " =\"'()[]{}<>,;"
```

Pick the set that matches how you use the output: whole paths and identifiers want a minimal list, while code and JSON are easier to navigate with more separators.
