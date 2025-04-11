-module(logger_color_formatter).
-include("colors.hrl").

-export([
    config_check/1,
    format/2
]).

-define(DEFAULT_FORMATTER, logger_formatter).

config_check(Config) ->
    ?DEFAULT_FORMATTER:check_config(update_config(os:getenv("NO_COLOR"), Config, debug)).

format(LogEvent = #{level := Level}, Config) ->
    Config2 = update_config(os:getenv("NO_COLOR"), Config, Level),
    ?DEFAULT_FORMATTER:format(LogEvent, Config2).

update_config(
    _NoColor = false,
    Config = #{template := Template, colors := Colors},
    Level
) ->
    Config#{template => update_template(Template, maps:merge(default_colors(), Colors), Level)};
update_config(_NoColor = false, Config = #{template := Template}, Level) ->
    Config#{template => update_template(Template, default_colors(), Level)};
update_config(_NoColor, Config, _Level) ->
    Config.

update_template(Template, Colors, Level) ->
    lists:map(
        fun
            (color) ->
                maps:get(Level, Colors);
            (reset) ->
                maps:get(reset, Colors);
            (Item) ->
                Item
        end,
        Template
    ).

default_colors() ->
    % Same default colors as Elixir logger.
    #{
        debug => ?NORMAL_CYAN,
        info => ?NORMAL_WHITE,
        notice => ?NORMAL_WHITE,
        warning => ?NORMAL_YELLOW,
        error => ?NORMAL_RED,
        critical => ?NORMAL_RED,
        alert => ?NORMAL_RED,
        emergency => ?NORMAL_RED,

        % Not a color.
        reset => ?RESET
    }.
