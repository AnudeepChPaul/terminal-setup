local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local f = ls.function_node
local t = ls.text_node
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

-- Function to get the current filename (no extension)
local function filename()
  return vim.fn.expand("%:t:r")
end

local function kebab_case_filename()
  local file = vim.fn.expand("%:t:r") -- get current filename without extension

  return file:gsub("[ _%.]", "-")
      :gsub("(%l)(%u)", "%1-%2")       -- Insert dash before uppercase letters (except at beginning)
      :gsub("%-+", "-")                -- Remove multiple consecutive dashes
      :gsub("^%-", ""):gsub("%-$", "") -- Trim leading/trailing dashes
      :lower()                         -- Convert to lowercase
end

local function pascal_case_filename()
  local file = vim.fn.expand("%:t:r"):gsub("[-_.]", " ")

  return file:gsub("(%S+)", function(word)
    return word:sub(1, 1):upper() .. word:sub(2)
  end):gsub("%s+", "")
end


return {
  s("fna", fmt(
    [[
const {} = ({}) => {{
  {}
}};
]],
    {
      i(1, "functionName"),
      i(2, "params"),
      i(0),
    }
  )),

  s("fn", fmt(
    [[
function {}({}) {{
  {}
}};
]],
    {
      i(1, "functionName"),
      i(2, "params"),
      i(0),
    }
  )),

  s("trc", fmt([[
import React, {{ PropsWithChildren }} from 'react';
import {{
  useImmer,
  UseImmerSetValue,
}} from "applications/Flex/shared/hooks/useImmer";
import {{ useTranslation }} from "react-i18next";
import {{ Box }} from "@twilio-paste/core/box";
import {{ useFlexToast }} from "applications/Flex/shared/hooks/useFlexToast";

export type {name}Props = {{
}}

export const {name}: React.FC<{name}Props> = (props: {name}Props) => {{
  const {{ t }} = useTranslation("flex");

  return (
    <Box data-testid="{k_name}-wrapper">{last}</Box>
  );
}};
]],
    {
      name = f(pascal_case_filename),
      rep("name"),
      last = i(0),
      k_name = f(kebab_case_filename),
    }, {strict = false}
  )),

  s("tuc", fmt([[
import React from 'react';
import {{
  useImmer,
  UseImmerSetValue,
}} from "applications/Flex/shared/hooks/useImmer";
import {{ useTranslation }} from "react-i18next";
import React, {{ PropsWithChildren, useContext }} from 'react';
import {{ useFlexToast }} from "applications/Flex/shared/hooks/useFlexToast";
import {{ FullPageCenteredSpinner }} from "applications/Flex/shared/components/cards/PageLoad";

export enum {name}Actions {{
  REFRESH = "REFRESH",
}}

export type {name}State = {{
}}

export type {name}ReturnType = [
  copilotContext: Readonly<{name}State>,
  setCopilotContext: UseImmerSetValue<{name}State>,
  (action: {name}Actions) => void
]

const Context = React.createContext<{name}ReturnType | null>(null);

export const use{name} = (): {name}ReturnType => {{
  const ctx = useContext(Context);

  if (!ctx) {{
    throw new Error(
      "use{name} was used outside of {name}.Provider"
    );
  }}

  return ctx as {name}ReturnType;
}};

export const {name}Component = React.FC<{name}Props> = (props: {name}Props) => {{
  const {{ t }} = useTranslation("flex");
  const {{ successToast, errorToast, clearAllToasts }} = useFlexToast();
  const [state, setState] = useImmer<{name}State>({{
    {state}
  }});

  const someAction = useSomeAction();

  const dispatcher = (action: {name}Actions): void => {{
    switch (action) {{
      case {name}Actions.REFRESH:
        someAction.request();
        return;
    }}
  }};

  return (
    <Context.Provider value={{[state, setState, dispatcher]}}>
      {{someAction.isLoading ? (
        <FullPageCenteredSpinner testid="{k_name}-page-loading-state" />
      ) : (
        children
      )}}
    </Context.Provider>
  );
}};
]], {
    name = f(pascal_case_filename),
    state = i(0),
    k_name = f(kebab_case_filename),
  }, {strict = false})),
}
