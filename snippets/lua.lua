---@diagnostic disable: undefined-global
local snippets = {
	s(
		{
			trig = "clangf",
			descr = "Comment string to disable clang formatting",
		},
		fmt(
			[[
      // clang-format off
      {}
      // clang-format on
      ]],
			{ i(1) }
		)
	),

	s(
		{
			trig = "strtok_ez",
			descr = "Easily use strtok with a for loop",
		},
		fmt(
			[[
      for (char *p = strtok({}, ","); p != NULL; p = strtok(NULL, ","))
      {{
        returnValue += atoi(p);
      }}
      {}
      ]],
			{ i(1, "InputStringToParse"), i(2) }
		)
	),
}

local autosnippets = {}

return snippets, autosnippets
