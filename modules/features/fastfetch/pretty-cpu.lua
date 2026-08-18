return function(args)
    local vendor = args.vendor
    local name = args.name

    if vendor == "GenuineIntel" then
        name = name:gsub("%(R%)", "")
        name = name:gsub("%(TM%)", "")
        name = name:gsub(" CPU", "")
        name = name:gsub("%s+", " ")
        name = name:gsub("^%d+%a+ Gen ", "")
        return name
    else
        return name
    end
end
