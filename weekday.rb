#!/usr/bin/ruby

class Year
    def initialize(year)
        @year = year
    end

    def isLeapYear?()
        ret = false
        if @year % 4 == 0
            ret = true
        end

        return ret
    end

    def getCode()
        century = @year/100             # integer division
        diff = @year - (century * 100)    # years from the start of the century
        code = diff + (diff/4)          # difference from the start plus the
                                        # number of leap years
        add = 0
        case century
            when 23
                add = 1
            when 22
                add = 3
            when 21
                add = 5
            when 20
                add = 0
            when 19
                add = 1
            when 18
                add = 3
            when 17
                add = 5
            when 16
                add = 0
        end

        code = code + add
        code = code % 7                 # drop multiples of seven!
    end
end

weekday = [ 'Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday' ]
month_code = {
    'January'   => 6,
    'February'  => 2,
    'March'     => 2,
    'April'     => 5,
    'May'       => 0,
    'June'      => 3,
    'July'      => 5,
    'August'    => 1,
    'September' => 4,
    'October'   => 6,
    'November'  => 2,
    'December'  => 4
}

#date = 'October 6, 2017'
date = ARGV[0]
sdate = date.split(',')
year = sdate[1].strip.to_i
year_code = Year.new(year)

month_and_day = sdate[0].split
month = month_and_day[0]

leap_year_correction = 0
if year_code.isLeapYear? and (month == 'January' or month == 'February')
    leap_year_correction = 1
end

day_code = month_and_day[1].to_i

weekcode = day_code + (month_code[month] - leap_year_correction) + year_code.getCode
weekcode = weekcode % 7
puts date + " => " + weekday[weekcode]

