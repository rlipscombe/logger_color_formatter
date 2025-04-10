-define(SGR(X), "\e[" X "m").

-define(NORMAL_RED, ?SGR("0;31")).
-define(NORMAL_GREEN, ?SGR("0;32")).
-define(NORMAL_YELLOW, ?SGR("0;33")).
-define(NORMAL_BLUE, ?SGR("0;34")).
-define(NORMAL_MAGENTA, ?SGR("0;35")).
-define(NORMAL_CYAN, ?SGR("0;36")).
-define(NORMAL_WHITE, ?SGR("0;37")).

-define(BOLD_RED, ?SGR("1;31")).
-define(BOLD_GREEN, ?SGR("1;32")).
-define(BOLD_YELLOW, ?SGR("1;33")).
-define(BOLD_BLUE, ?SGR("1;34")).
-define(BOLD_MAGENTA, ?SGR("1;35")).
-define(BOLD_CYAN, ?SGR("1;36")).
-define(BOLD_WHITE, ?SGR("1;37")).

-define(RESET, ?SGR("0")).
