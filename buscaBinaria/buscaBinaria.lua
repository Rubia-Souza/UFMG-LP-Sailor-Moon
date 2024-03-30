function readInput(filePath)
    local inputFile = io.open(filePath, "r")
    if not inputFile then
        print("[ERROR]: Erro ao abrir o arquivo. Verifique se o caminho esta correto")
        return
    end

    local numberList = {}
    for line in inputFile:lines() do
        for number in line:gmatch("%d+") do
            table.insert(numberList, tonumber(number))
        end
    end

    inputFile:close()

    return numberList
end

function quickSort(list)
    local function partition(list, leftIndex, rightIndex)
        local pivot = list[rightIndex]
        local i = leftIndex - 1

        for j = leftIndex, rightIndex - 1 do
            if list[j] <= pivot then
                i = i + 1
                list[i], list[j] = list[j], list[i]
            end
        end

        list[i + 1], list[rightIndex] = list[rightIndex], list[i + 1]
        return i + 1
    end

    local function quickSortRecursive(list, leftIndex, rightIndex)
        if leftIndex >= rightIndex then
            return
        end

        local pivotIndex = partition(list, leftIndex, rightIndex)

        quickSortRecursive(list, leftIndex, pivotIndex - 1)
        quickSortRecursive(list, pivotIndex + 1, rightIndex)
    end

    quickSortRecursive(list, 1, #list)
end

function binarySearch(list, numberToSearch)
    quickSort(list)
    local leftIndex = 1
    local rightIndex = #list
    
    while leftIndex <= rightIndex do
        local middleIndex = math.floor((leftIndex + rightIndex) / 2)
        local middleValue = list[middleIndex]

        if middleValue == numberToSearch then
            return middleIndex
        elseif middleValue < numberToSearch then
            leftIndex = middleIndex + 1
        else
            rightIndex = middleIndex - 1
        end
    end

    return -1
end

function search(inputFilePath, numberToSearch)
    local numberList = readInput(inputFilePath)
    if not numberList then
        print("[ERROR]: Erro ao gerar lista de numeros.")
        os.exit(1)
    end
    
    local index = binarySearch(numberList, numberToSearch)
    if index == -1 then
        print(string.format("O numero %d nao faz parte da lista de inteiros.", numberToSearch))
        return 0
    else
        print(string.format("O numero %d faz parte da lista de inteiros.", numberToSearch))
        return 1
    end
end

function main()
    print("Digite o caminho do arquivo de entrada completo com extensao do arqivo: ")
    local inputFilePath = io.read()
    
    print("Digite o numero que deseja buscar na lista de inteiros: ")
    local numberToSearch = tonumber(io.read())
    
    search(inputFilePath, numberToSearch)
end

main()