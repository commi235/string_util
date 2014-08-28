create or replace package string_util_pkg
as

  /*

  Purpose:    The package handles general string-related functionality

  Remarks:  

  Who     Date        Description
  ------  ----------  -------------------------------------
  MBR     21.09.2006  Created
  
  */
  
  g_max_pl_varchar2_def          VARCHAR2(32767);
  SUBTYPE t_max_pl_varchar2      IS g_max_pl_varchar2_def%TYPE;
  
  g_max_db_varchar2_def          VARCHAR2(4000);
  SUBTYPE t_max_db_varchar2      IS g_max_db_varchar2_def%TYPE;

  g_default_separator            CONSTANT VARCHAR2(1) := ';';
  g_param_and_value_separator    CONSTANT VARCHAR2(1) := '=';
  g_param_and_value_param        CONSTANT VARCHAR2(1) := 'P';
  g_param_and_value_value        CONSTANT VARCHAR2(1) := 'V';
  
  g_yes                          CONSTANT VARCHAR2(1) := 'Y';
  g_no                           CONSTANT VARCHAR2(1) := 'N';
  
  g_line_feed                    CONSTANT VARCHAR2(1) := chr(10);
  g_new_line                     CONSTANT VARCHAR2(1) := chr(13);
  g_carriage_return              CONSTANT VARCHAR2(1) := chr(13);
  g_crlf                         CONSTANT VARCHAR2(2) := g_carriage_return || g_line_feed;
  g_tab                          CONSTANT VARCHAR2(1) := chr(9);
  g_ampersand                    CONSTANT VARCHAR2(1) := chr(38); 

  g_html_entity_carriage_return  CONSTANT VARCHAR2(5) := '&#13;';
  g_html_nbsp                    CONSTANT VARCHAR2(6) := '&nbsp;';
  g_html_br                      CONSTANT VARCHAR2(6) := '<br />';

  -- return string merged with substitution values
  FUNCTION get_str( p_msg IN VARCHAR2
                  , p_value1 IN VARCHAR2 := NULL
                  , p_value2 IN VARCHAR2 := NULL
                  , p_value3 IN VARCHAR2 := NULL
                  , p_value4 IN VARCHAR2 := NULL
                  , p_value5 IN VARCHAR2 := NULL
                  , p_value6 IN VARCHAR2 := NULL
                  , p_value7 IN VARCHAR2 := NULL
                  , p_value8 IN VARCHAR2 := NULL
                  )
    RETURN VARCHAR2;

  -- get the sub-string at the Nth position 
  FUNCTION get_nth_token( p_text IN VARCHAR2
                        , p_num IN NUMBER
                        , p_separator IN VARCHAR2 := g_default_separator
                        )
    RETURN VARCHAR2;
  
  -- get the number of sub-strings
  FUNCTION get_token_count( p_text IN VARCHAR2
                          , p_separator IN VARCHAR2 := g_default_separator
                          )
    RETURN NUMBER;

  -- convert string to number
  function str_to_num (p_str in VARCHAR2,
                       p_decimal_separator in VARCHAR2 := null,
                       p_thousand_separator in VARCHAR2 := null,
                       p_raise_error_if_parse_error in boolean := false,
                       p_value_name in VARCHAR2 := null) return number;
                       
  -- copy part of string
  function copy_str (p_string in VARCHAR2,
                     p_from_pos in number := 1,
                     p_to_pos in number := null) return VARCHAR2;
                     
  -- remove part of string
  function del_str (p_string in VARCHAR2,
                    p_from_pos in number := 1,
                    p_to_pos in number := null) return VARCHAR2;
 
  -- get value from parameter list with multiple named parameters
  function get_param_value_from_list (p_param_name in VARCHAR2,
                                      p_param_string in VARCHAR2,
                                      p_param_separator in VARCHAR2 := g_default_separator,
                                      p_value_separator in VARCHAR2 := g_param_and_value_separator) return VARCHAR2;

  -- remove all whitespace from string
  function remove_whitespace (p_str in VARCHAR2,
                              p_preserve_single_blanks in boolean := false,
                              p_remove_line_feed in boolean := false,
                              p_remove_tab in boolean := false) return VARCHAR2;
                              
  -- remove all non-numeric characters from string
  function remove_non_numeric_chars (p_str in VARCHAR2) return VARCHAR2;

  -- remove all non-alpha characters (A-Z) from string
  function remove_non_alpha_chars (p_str in VARCHAR2) return VARCHAR2;

  -- returns true if string is "empty" (contains only whitespace characters)
  function is_str_empty (p_str in VARCHAR2) return boolean;

  -- returns true if string is a valid number
  function is_str_number (p_str in VARCHAR2,
                          p_decimal_separator in VARCHAR2 := null,
                          p_thousand_separator in VARCHAR2 := null) return boolean;

  -- returns substring and indicates if string has been truncated
  function short_str (p_str in VARCHAR2,
                      p_length in number,
                      p_truncation_indicator in VARCHAR2 := '...') return VARCHAR2;

  -- return either name or value from name/value pair
  function get_param_or_value (p_param_value_pair in VARCHAR2,
                               p_param_or_value in VARCHAR2 := g_param_and_value_value,
                               p_delimiter in VARCHAR2 := g_param_and_value_separator) return VARCHAR2;

  -- add item to delimited list
  function add_item_to_list (p_item in VARCHAR2,
                             p_list in VARCHAR2,
                             p_separator in VARCHAR2 := g_default_separator) return VARCHAR2;
                             
  -- convert string to boolean
  function str_to_bool (p_str in VARCHAR2) return boolean;

  -- convert string to boolean string
  function str_to_bool_str (p_str in VARCHAR2) return VARCHAR2;
  
  -- get pretty string
  function get_pretty_str (p_str in VARCHAR2) return VARCHAR2;

  -- parse string to date, accept various formats
  function parse_date (p_str in VARCHAR2) return date;

  -- split delimited string to rows
  function split_str (p_str in VARCHAR2,
                      p_delim in VARCHAR2 := g_default_separator) return t_str_array pipelined;

  -- create delimited string from cursor
  function join_str (p_cursor in sys_refcursor,
                     p_delim in VARCHAR2 := g_default_separator) return VARCHAR2;

  -- replace several strings
  function multi_replace (p_string in VARCHAR2,
                          p_search_for in t_str_array,
                          p_replace_with in t_str_array) return VARCHAR2;

  -- replace several strings (clob version)
  function multi_replace (p_clob in clob,
                          p_search_for in t_str_array,
                          p_replace_with in t_str_array) return clob;

  -- return true if item is in list
  function is_item_in_list (p_item in VARCHAR2,
                            p_list in VARCHAR2,
                            p_separator in VARCHAR2 := g_default_separator) return boolean;


  -- randomize array
  function randomize_array (p_array in t_str_array) return t_str_array;

  -- return true if two values are different
  function value_has_changed (p_old in VARCHAR2,
                              p_new in VARCHAR2) return boolean;

                              
end string_util_pkg;
/

