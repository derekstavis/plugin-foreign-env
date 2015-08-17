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


function fenv.parse.divider
    echo '---DIVIDER---'
end

function fenv.parse.before
    for value in $argv
        if [ $value = (fenv.parse.divider) ]
            break
        end

        echo $value
    end
end

function fenv.parse.after
    set printable 0

    for value in $argv
        if [ $printable = 1 ]
            echo $value
        end

        if [ $value = (fenv.parse.divider) ]
            set printable 1
        end
    end
end

function fenv.parse.diff
    set SEGMENTED_ENVIRONMENT (echo $argv | tr ' ' '\n')
    set OLD_ENV (fenv.parse.before $SEGMENTED_ENVIRONMENT)
    set NEW_ENV (fenv.parse.after $SEGMENTED_ENVIRONMENT)

    omf.log blue "$OLD_ENV" >&2
    omf.log green "$NEW_ENV" >&2

    for environment in $NEW_ENV
        if not contains $environment $OLD_ENV
            echo $environment
        end
    end
end
