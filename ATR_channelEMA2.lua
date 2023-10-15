Settings =
{
    Name = "ATR_channelEMA2",
    period = 50,
    value_type = "C",

    line=
    {
       {
        Name = "EMA",
        Color = RGB(255, 0, 0),
        Type = TYPE_LINE,
        Width = 2
        }
    }
}

function average()
    local sum = 0
    for i = index - Settings.period + 1, index do
        sum = sum +C(i)
    end
    return sum/Settings.period
end

function Init()
    return 1
end

--EMAt = ? x current price + (1- ?) x EMAt-1

EMA_pred = 0 --глобальная переменная

function OnCalculate(index)

    if index < Settings.period then
        return nil
    else

        local a = 0 --коэффициент
        a = 2 / (1 + Settings.period)

        local EMA = 0 --EMA

        EMA_pred = average()

        for i = index - Settings.period + 1, index do
            EMA = C(i) * a + EMA_pred * (1 - a)
            EMA_pred = EMA
        end
    end
    return EMA
end