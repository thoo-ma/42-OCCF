let s:static_function_header = [
	\"/******************************************************************************/",
	\"/*                                                                            */",
	\"/*     Static functions                                                       */",
	\"/*                                                                            */",
	\"/******************************************************************************/"
\]

let s:member_function_header = [
	\"/******************************************************************************/",
	\"/*                                                                            */",
	\"/*     Member functions                                                       */",
	\"/*                                                                            */",
	\"/******************************************************************************/"
\]

let s:constructor_header = [
	\"/******************************************************************************/",
	\"/*                                                                            */",
	\"/*     Constructors                                                           */",
	\"/*                                                                            */",
	\"/******************************************************************************/"
\]

let s:destructor_header = [
	\"/******************************************************************************/",
	\"/*                                                                            */",
	\"/*     Destructor                                                             */",
	\"/*                                                                            */",
	\"/******************************************************************************/"
\]

let s:operator_header = [
	\"/******************************************************************************/",
	\"/*                                                                            */",
	\"/*     Operators                                                              */",
	\"/*                                                                            */",
	\"/******************************************************************************/"
\]

" Filename
let s:filename = expand("%:t")
let s:basename = expand("%:r")
let s:extension = expand("%:e")

" Definitions
let s:default_constructor_definition = s:basename . "::" . s:basename . "(void) { }"
let s:copy_constructor_definition = s:basename . "::" . s:basename . "(" . s:basename . " const & a) { }"
let s:destructor_definition = s:basename . "::~" . s:basename . "(void) { }"
let s:assignation_operator_definition = [
	\ s:basename . " &",
	\ s:basename . "::operator=(" . s:basename . " const & rhs) {",
	\ "    return *this;",
	\ "}"
\]

" Preprocessor directives
let s:ifndef = "#ifndef " . toupper(s:basename) . "_HPP"
let s:define = "#define " . toupper(s:basename) . "_HPP"
let s:endif = "#endif /* " . toupper(s:basename) . "_HPP */"
let s:include = "#include \"" . s:basename . ".hpp\""

" Declarations
let s:copy_constructor_declaration = "    " . s:basename . "(" . s:basename . " const & a);"
let s:default_constructor_declaration = "    " . s:basename . "(void);"
let s:default_destructor_declaration = "    ~" . s:basename . "(void);"
let s:assignation_operator_declaration = "    " . s:basename . " & " . "operator=(" . s:basename . " const & rhs);"

let s:class = [
	\ "class " . s:basename . " {",
	\ "",
	\ "public:",
	\ "",
	\ s:copy_constructor_declaration,
	\ s:default_constructor_declaration,
	\ s:default_destructor_declaration,
	\ "",
	\ s:assignation_operator_declaration,
	\ "",
	\ "private:",
	\ "",
	\ "};",
\]

function! s:coplienform()
	if s:extension == 'cpp'
		call append(0, s:assignation_operator_definition) | call append(0, "")
		call append(0, s:operator_header)                 | call append(0, "")
		call append(0, s:destructor_definition)           | call append(0, "")
		call append(0, s:destructor_header)               | call append(0, "")
		call append(0, s:default_constructor_definition)  | call append(0, "")
		call append(0, s:copy_constructor_definition)     | call append(0, "")
		call append(0, s:constructor_header)              | call append(0, "")
		call append(0, s:member_function_header)          | call append(0, "")
		call append(0, s:include)
		:$ delete 1 " remove last line
		"call append(0, s:static_function_header)
    elseif s:extension == 'hpp'
		call append(0, s:endif)  | call append(0, "")
		call append(0, s:class)  | call append(0, "")
		call append(0, s:define)
		call append(0, s:ifndef)
		:$ delete 1 " remove last line
	endif
endfunction

command! CoplienForm call s:coplienform ()
