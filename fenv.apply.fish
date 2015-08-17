# The MIT License (MIT)

# Copyright (c) 2015 Derek Willian Stavis

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.


function fenv.apply
    set VARIABLES $argv

    omf.log magenta "fenv.apply: Environment diff:" >&2
    omf.log yellow "fenv.apply: $ENVIRONMENT_DIFF" >&2

    for variable in $VARIABLES
        set KEY (echo $variable | sed -e 's/=.*//')
        set VALUE (echo $variable | sed -e 's/.*=//')
        set COMMAND "set -g -x $KEY $VALUE"

        if [ -z $KEY -o -z $VALUE ]
            omf.log magenta "fenv.apply: Failed applying: " >&2
            omf.log yellow "fenv.apply: would call '$COMMAND'" >&2
            continue
        end

        eval "$COMMAND" > /dev/null 2>&1
    end
end