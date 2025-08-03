{pkgs, ...}: {
  programs = {
    bash = {
      enable = true;
      enableCompletion = true;

      shellAliases = {
        ls = "eza --long --grid --header --classify --icons=always --git";
        tree = "eza --long --grid --header --classify --icons=always --git -T";
        ts = "tmux-sessionizer";
        rm = "rm -r";
        cp = "cp -r";
        grep = "rg";
        cat = "bat";
        cd = "z";
      };

      # igore duplicates and commands starting with space
      historyControl = ["ignoreboth"];

      # set shell prompt
      initExtra = ''
        __bash_prompt() {
          userpart='`export XIT=$? \
                    && echo -n " \[\033[0;96m\]\u@\[\033[0;33m\]\h"`'
          local gitbranch='`\
                export BRANCH=$(git symbolic-ref --short HEAD 2>/dev/null || git rev-parse --short HEAD 2>/dev/null); \
                  if [ "$BRANCH" != "" ]; then \
                      echo -n "\[\033[0;36m\](\[\033[1;31m\]$BRANCH" \
                      && if git ls-files --error-unmatch -m --directory --no-empty-directory -o --exclude-standard ":/*" > /dev/null 2>&1; then \
                              echo -n " \[\033[1;33m\]✗"; \
                          fi \
                          && echo -n "\[\033[0;36m\]) "; \
                  fi`'
          local lightblue='\[\033[1;34m\]'
          local removecolor='\[\033[0m\]'
          PS1="[$userpart $lightblue\w $gitbranch$removecolor]\$ "
          unset -f __bash_prompt
        }
        __bash_prompt
      '';
    };

    zoxide = {
      enable = true;
      enableBashIntegration = true;
    };

    fzf = {
      enable = true;
      enableBashIntegration = true;
    };

    direnv = {
      enable = true;
      enableBashIntegration = true;
      nix-direnv.enable = true;
    };
  };
}
