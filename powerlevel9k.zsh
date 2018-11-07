#############################
# PowerLevel9K theme config #
#############################

# Customise Prompts

POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_RPROMPT_ON_NEWLINE=true

POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX='%F{blue}\u256D\u2500%F{white}'
POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX='%F{blue}\u2570\uf460%F{white} '

POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir vcs virtualenv)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status command_execution_time)

# Uncomment following line to disable right prompt
# POWERLEVEL9K_DISABLE_RPROMPT=true

# Customise segments

POWERLEVEL9K_TIME_FORMAT="%D{%H:%M}"
POWERLEVEL9K_COMMAND_EXECUTION_TIME_THRESHOLD=1
POWERLEVEL9K_SHORTEN_DIR_LENGTH=2

# Uncomment following line to change directory shorten strategy
# POWERLEVEL9K_SHORTEN_STRATEGY="truncate_middle"

# Customise colors

#POWERLEVEL9K_BATTERY_CHARGING='yellow'
#POWERLEVEL9K_BATTERY_CHARGED='green'
#POWERLEVEL9K_BATTERY_DISCONNECTED='$DEFAULT_COLOR'
#POWERLEVEL9K_BATTERY_LOW_THRESHOLD='10'
#POWERLEVEL9K_BATTERY_LOW_COLOR='red'
#POWERLEVEL9K_COMMAND_EXECUTION_TIME_BACKGROUND=245
#POWERLEVEL9K_COMMAND_EXECUTION_TIME_FOREGROUND='black'
POWERLEVEL9K_VIRTUALENV_BACKGROUND='005'
