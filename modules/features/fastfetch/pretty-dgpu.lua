return function(args)
    if args.type == "Discrete" and args.vendor == "NVIDIA" then
        return args.vendor .. " " .. args.name:gsub("Mobile / ", "")
    end

    return
end
