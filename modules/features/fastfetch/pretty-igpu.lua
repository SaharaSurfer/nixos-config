return function(args)
    if args.type == "Integrated" then
        return args.vendor .. " " .. args.name
    end

    return
end
