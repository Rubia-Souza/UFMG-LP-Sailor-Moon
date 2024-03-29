function splitStringByTab(str)
    local fields = {}
    local pattern = string.format("([^%s]+)", " ")
    string.gsub(str, pattern, function(c) fields[#fields+1] = c end)
    return fields
end

function readMatrixFromFile(filePath)
    local file = io.open(filePath, "r")
    local matrix = {}
    local n, m

    if file then
        -- Reads first line with number of rows n and columns m
        local line = file:read("*l")
        local dimensions = splitStringByTab(line, " ")
        n = tonumber(dimensions[1])
        m = tonumber(dimensions[2])

        -- Reads matrix values
        for i = 1, n do
            line = file:read("*l")
            local row = splitStringByTab(line, " ")
            matrix[i] = {}
            for j = 1, m do
                matrix[i][j] = tonumber(row[j])
            end
        end

        file:close()
    else
        error("Could not open the file.")
    end

    return matrix, n, m
end

function printMatrix(matrix, n, m)
    print(string.format("Dimensions: %d x %d", n, m))
    for i = 1, n do
        for j = 1, m do
            io.write(string.format("%d ", matrix[i][j]))
        end
        print()
    end
end

local matrix, n, m = readMatrixFromFile("./multiplicaçãoDeMatrizes/exemplos/matrizes/A.txt")

printMatrix(matrix, n, m)
