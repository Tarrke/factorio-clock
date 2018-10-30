if not trk then trk = {} end

-- Wrapper so we can log or not
function trk.log(message,callback)
    if game then
        for _, p in pairs(game.players) do
            if (callback(p)) then
                p.print(message)
            end
        end
    else
        error(serpent.dump(message, {compact = false, nocode = true, indent = ' '}))
    end
end
