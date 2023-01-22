-module(logger_color_formatter).

-export([config_check/1, format/2]).

config_check(Config) ->
    logger_formatter:check_config(update_config(Config, debug)).

format(LogEvent = #{level := Level}, Config) ->
    Config2 = update_config(Config, Level),
    logger_formatter:format(LogEvent, Config2).

update_config(Config = #{template := Template}, Level) ->
    Config#{template => update_template(Template, Level)};
update_config(Config, _Level) ->
    Config.

update_template(Template, Level) ->
    lists:map(fun
            (color) -> default_color(Level);
            (reset) -> "\e[0m";
            (Item) -> Item
        end, Template).

default_color(debug) -> "\e[0;38m";
default_color(info) -> "\e[1;37m";
default_color(notice) -> "\e[1;36m";
default_color(warning) -> "\e[1;33m";
default_color(error) -> "\e[1;31m";
default_color(critical) -> "\e[1;35m";
default_color(alert) -> "\e[1;44m";
default_color(emergency) -> "\e[1;41m".
