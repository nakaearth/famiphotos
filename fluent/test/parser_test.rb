require 'fluent/configurable'
require 'fluent/config'
require 'fluent/parser'

# log = 'Jul 16 00:45:47 BJA login[58879]: USER_PROCESS: 58879 ttys002'
log = 'Jul 16 00:45:47 BJA login[58879]: USER_PROCESS: 58879 ttys002'

regexp = /^(?<date>\w{3} \d\d (\d{2}:){2}\d{2}) (?<host>\w+) (?<role>\w+)\[(?<pid>\d+)\]: (?<event>\w+): (?<info>\d+) (?<tty>.+)$/
parser = Fluent::TextParser::RegexpParser.new(regexp)
p parser.parse(log)
