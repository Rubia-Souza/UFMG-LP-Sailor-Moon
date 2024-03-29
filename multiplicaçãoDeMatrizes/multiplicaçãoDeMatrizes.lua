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

function printMatrix(matrix)
    local n = #matrix
    local m = #matrix[1]
    print(string.format("Dimensions: %d x %d", n, m))
    for i = 1, n do
        for j = 1, m do
            io.write(string.format("%d ", matrix[i][j]))
        end
        print()
    end
end

function multiplyMatrix(matrixA, matrixB)

    local nC = #matrixA
    local mC = #matrixB[1]
    local innerDimension = #matrixA[1]

    local matrixC = {}

    for i = 1, nC do

        matrixC[i] = {}

        for j = 1, mC do

            local mult = 0
            local sum = 0

            for k = 1, innerDimension do

                mult = matrixA[i][k] * matrixB[k][j]
                sum = sum + mult

            end

            matrixC[i][j] = sum

        end

    end

    return matrixC

end

local matrixA, nA, mA = readMatrixFromFile("./multiplicaçãoDeMatrizes/exemplos/matrizes/A.txt")
local matrixB, nB, mB = readMatrixFromFile("./multiplicaçãoDeMatrizes/exemplos/matrizes/B.txt")
local matrixC, nC, mC = readMatrixFromFile("./multiplicaçãoDeMatrizes/exemplos/matrizes/C.txt")


local matrixA_B = multiplyMatrix(matrixA, matrixB)
local matrixB_C = multiplyMatrix(matrixB, matrixC)
local matrixA_B_C = multiplyMatrix(matrixA, matrixB_C)
local matrixB_C_A = multiplyMatrix(matrixB_C, matrixA)
local matrixB_C_B = multiplyMatrix(matrixB_C, matrixB)

print("--------- matrix matrixA_B ---------")
printMatrix(matrixB_C_B)
print()

print("--------- matrix matrixB_C ---------")
printMatrix(matrixB_C)
print()

print("--------- matrix matrixA_B_C ---------")
printMatrix(matrixA_B_C)
print()

print("--------- matrix matrixB_C_A ---------")
printMatrix(matrixB_C_A)
print()

print("--------- matrix matrixB_C_B ---------")
printMatrix(matrixB_C_B)
print()
