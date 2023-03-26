function onInit()
    -- cargar la configuración del módulo si existe
    loadConfig()
    print("Cronometro cargado exitosamente by IrwencenaUwU")
    MP.RegisterEvent("onChatMessage", "onChatMessage")
end

function onChatMessage(senderID, name, message)
    if name == "Irwencena" then
        if message == "/timer" then
            startTimer()
            return 1
        elseif message == "/stopT" then
            stopTimer()
            return 1
        elseif message == "/raceT" then
            raceTimer()
            return 1
        elseif message == "/lang en" then
            setLanguage("en")
            MP.SendChatMessage(-1, "Language set to English.")
            return 1
        elseif message == "/lang es" then
            setLanguage("es")
            MP.SendChatMessage(-1, "Idioma establecido a Español.")
            return 1
        end
    end
end

local timerRunning = false
local startTime = 0
local stopTime = 0
local lang = "es" -- idioma predeterminado
function loadConfig()
    -- cargar la variable de idioma desde el archivo de configu
    -- o establecer el idioma predeterminado si no existe la configuración
end

function setLanguage(newLang)
    -- guardar el idioma seleccionado en el archivo de configuración
    -- o establecer el idioma predeterminado si no existe la configuración
    lang = newLang
end
--inicia el contador
function startTimer()
    if not timerRunning then
        startTime = os.clock()
        timerRunning = true
        if lang == "en" then
            MP.SendChatMessage(-1, "Timer started.")
        elseif lang == "es" then
            MP.SendChatMessage(-1, "Cronómetro iniciado.")
        end
    else
        if lang == "en" then
            MP.SendChatMessage(-1, "Timer is already running.")
        elseif lang == "es" then
            MP.SendChatMessage(-1, "El cronómetro ya está en marcha.")
        end
    end
end
--detiene el contador y transforma los datos en formato de minutos segundos y milisegundos para mostrarse en el chat el cual todos pueden ver el tiempo
function stopTimer()
    if timerRunning then
        stopTime = os.clock()
        timerRunning = false
        local elapsed = (stopTime - startTime) * 1000
        local minutes = math.floor(elapsed / 60000)
        local seconds = math.floor((elapsed - minutes * 60000) / 1000)
        local milliseconds = math.floor((elapsed - minutes * 60000 - seconds * 1000) / 1)
        if lang == "en" then
            MP.SendChatMessage(-1, string.format("Timer stopped. Elapsed time: %02d:%02d.%03d", minutes, seconds, milliseconds))
        elseif lang == "es" then
            MP.SendChatMessage(-1, string.format("Cronómetro detenido. Tiempo transcurrido: %02d:%02d.%03d", minutes, seconds, milliseconds))
        end
    else
        if lang == "en" then
            MP.SendChatMessage(-1, "Timer is not running.")
        elseif lang == "es" then
            MP.SendChatMessage(-1, "No hay cronómetro activo.")
        end
    end
end
--simplemente muestra un temporizador de 5 segundos y luego inicia el cronometro usado para rally
function raceTimer()
    if not timerRunning then

        if lang == "en" then
        MP.SendChatMessage(-1, "Starting countdown...")
        elseif lang == "es" then
        MP.SendChatMessage(-1, "Preparate...")
        end


        for i = 5, 1, -1 do
            if lang == "en" then
                MP.SendChatMessage(-1, tostring(i).."...")
            elseif lang == "es" then
                MP.SendChatMessage(-1, tostring(i).."...")
            end
            MP.Sleep(1000)
        end
        if lang == "en" then
            MP.SendChatMessage(-1, "GO!")
        elseif lang == "es" then
            MP.SendChatMessage(-1, "¡YA!")
        end
        startTimer()
    else
        if lang == "en" then
            MP.SendChatMessage(-1, "Timer is already running.")
        elseif lang == "es" then
            MP.SendChatMessage(-1, "El cronómetro ya está en marcha.")
        end
    end
end
