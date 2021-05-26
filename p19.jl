module p19

# You are given the following information, but you may prefer to do some research for yourself.

# 1 Jan 1900 was a Monday.
# Thirty days has September,
# April, June and November.
# All the rest have thirty-one,
# Saving February alone,
# Which has twenty-eight, rain or shine.
# And on leap years, twenty-nine.
# A leap year occurs on any year evenly divisible by 4, but not on a century
# unless it is divisible by 400.
# How many Sundays fell on the first of the month during the twentieth century
# (1 Jan 1901 to 31 Dec 2000)?

function pd(day, week, month, year, stop=false)
    months = [
        "Jan", "Feb", "Mar", "Apr",
        "May", "Jun", "Jul", "Aug",
        "Sep", "Oct", "Nov", "Dec"
    ]
    weeks = [
        "Su", "Mo", "Tu", "We", "Th", "Fr", "Sa"
    ]

    if stop
        print(day, "/", months[month], "/", year, " ", weeks[week])
        readline()
    else
        println(day, "/", months[month], "/", year, " ", weeks[week])
    end

    # readline()
end

function leap_year(year)
    if year%4 == 0
        if year%100 == 0
            if year%400 == 0
                return true
            else
                return false
            end
        else
            return true
        end
    else
        return false
    end
end
function brute_force(sday, smonth, syear, eday, emonth, eyear, count_week=1)
    thirty = [4, 6, 9, 11]
    thirtyone = [1, 3, 5, 7, 8, 10, 12]

    day = 1
    week = 2
    month = 1
    year = 1900

    count = 0
    while true
        # day != eday && month != emonth && year != eyear

        # if week == count_week && day == 1
        #     count += 1
        # end

        day += 1
        week += 1
        if week > 7
            week = 1
        end
        if day >= 29
            # pd(day, month, year)
            if month == 2
                if leap_year(year)
                    if day >= 30
                        day = 1
                        month += 1
                    end
                else
                    if day >= 29
                        day = 1
                        month += 1
                    end
                end
            else
                if month in thirty
                    if day >= 31
                        day = 1
                        month += 1
                    end
                elseif month in thirtyone
                    if day >= 32
                        day = 1
                        month += 1
                    end
                end
            end

            if month >= 13
                month = 1
                year += 1
            end
        end

        if year >= eyear && month >= emonth && day >= eday
            break
        end
        if year < syear || (year == syear && month < smonth) || (year == syear && month == smonth && day < sday)
            # pd(day, week, month, year)
            continue
        end
        if day == 1
            if week == count_week
                # pd(day, week, month, year)
                count += 1
            end
        end
    end
    return count
end

function ans()

end

end
