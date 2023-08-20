module Main (main) where

import Data.List (sortBy)

-- LISTA EXTRA 2

{--
1. Defina uma função
 penultimo :: [a]-> a
 que devolve o penúltimo elemento de uma lista, apresentando uma
 mensagem de erro nos casos de lista vazia e lista com apenas um elemento.
--}
penultimo :: [a] -> a
penultimo [] = error "lista vazia"
penultimo [_] = error "lista com apenas um elemento"
penultimo [x, _] = x
penultimo (_ : xs) = penultimo xs

{--
2. Defina uma função
 maximoLocal :: [Int]-> [Int]
 que devolve uma lista com os máximos locais de uma lista de inteiros.
 Um máximo local é um elemento maior que seu antecessor e que seu
 sucessor.
 Por exemplo, em [1,3,4,2,5] 4 é um máximo local, mas 5 não,
 pois não possui sucessor.
--}
maximoLocal :: [Int] -> [Int]
maximoLocal [] = []
maximoLocal [_] = []
maximoLocal [_, _] = []
maximoLocal (x : y : z : xs)
  | y > x && y > z = y : maximoLocal (y : z : xs)
  | otherwise = maximoLocal (y : z : xs)

{--
3. Usando compreensão de listas, defina a função
 perfeitos :: Int-> [Int]
 que recebe um inteiro n e retorna uma lista dos números perfeitos até
 n. Um número perfeito é igual à soma de seus fatores, excluindo a
 si mesmo. O número 28 é perfeito, pois 1 + 2 + 4 + 7 + 14 = 28.
 Exemplo:
 > perfeitos 500
 [6,28,496]
--}
perfeitos :: Int -> [Int]
perfeitos n =
  [x | x <- [1 .. n], x == sum ([d | d <- [1 .. x - 1], x `mod` d == 0])]

{--
4. Defina a função
produtoEscalar :: Num a => [a]-> [a]-> a
 que devolve o produto escalar de dois vetores, usando compreensão de
 listas.
--}
produtoEscalar :: (Num a) => [a] -> [a] -> a
produtoEscalar xs ys = sum [x * y | (x, y) <- zip xs ys]

-- produtoEscalarRec :: (Num a) => [a] -> [a] -> a
-- produtoEscalarRec [] [] = 0
-- produtoEscalarRec (x : xs) (y : ys) = x * y + produtoEscalarRec xs ys
{--
5. Escreva uma função recursiva
 palindromo :: [Int]-> Bool
 que verifica se os elementos da lista formam um palíndromo.
--}
-- reverse' :: [a] -> [a]
-- reverse' [] = []
-- reverse' (x : xs) = reverse' xs ++ [x]
palindromo :: [Int] -> Bool
palindromo xs = xs == reverse xs

{--
6. Defina uma função
 ordenaListas :: (Num a, Ord a) => [[a]]-> [[a]]
 que ordene uma lista de listas pelo tamanho de suas sublistas.
--}
ordenaListas :: [[a]] -> [[a]]
ordenaListas = sortBy compareLength
  where
    compareLength xs ys = compare (length xs) (length ys)

{--
7. Mostre como a compreensão de lista
 coord :: [a]-> [a]-> [(a,a)]
 coord x y = [(i,j) | i <- x, j <- y]
 que possui duas funções geradoras, pode ser redefinida com duas lis
tas de compreensão aninhadas, cada uma contendo uma única função
 geradora.
--}
coordNested :: [a] -> [a] -> [(a, a)]
coordNested x y = concat [[(i, j) | j <- y] | i <- x]

{--
8. O algoritmo de Luhn para a verificação dos dígitos de um cartão de
 crédito segue os seguintes passos:
 (a) considere cada dígito como um número
 (b) a partir da direita, dobre os números alternadamente, começando
 pelo penúltimo
 (c) some todos os dígitos dos números
 (d) se o total for divisível por 10, o número do cartão é válido.
 Em seguida:
 --}
{--
 (a) Defina as funções
 digitosRev :: Int-> [Int]
 que converte um inteiro em uma lista contendo seus dígitos na
 ordem reversa.
--}
digitosRev :: Int -> [Int]
digitosRev 0 = []
digitosRev x = mod x 10 : digitosRev (x `div` 10)

{--
 (b) Escreva a função
 dobroAlternado :: [Int]-> [Int]
que recebe uma lista de números e dobra a partir da esquerda o
 segundo, quarto etc, elemento, devolvendo uma lista atualizada.
 Note que por termos escrito a função anterior para retornar os
 dígitos invertidos, podemos fazer essa operação da esquerda ao
 invés de da direita conforme descrição do algoritmo. Por exemplo,
 para [3,5,6,4] a a saída é [3,10,6,8].
--}
dobroAlternado :: [Int] -> [Int]
dobroAlternado [] = []
dobroAlternado [x] = [x]
dobroAlternado (x : y : xs) = x : y * 2 : dobroAlternado xs

-- função auxiliar
digitosDobrados :: [Int] -> [Int]
digitosDobrados [] = []
digitosDobrados [x] =
  if x > 10
    then digitosRev x
    else [x]
digitosDobrados (x : xs) =
  if x > 10
    then digitosRev x ++ digitosDobrados xs
    else x : digitosDobrados xs

{--
 (c) Defina a função
 somaDigitos :: [Int]-> Int
 que soma todos os dígitos da lista de inteiros. Com o uso função
 anterior, alguns números possuem dois dígitos, que precisam ser
 somados individualmente. Exemplo: [6,5,12,4] = 6 + 5 + 1 + 2 + 4 = 18
--}
somaDigitos :: [Int] -> Int
somaDigitos [] = 0
somaDigitos [x] = x
somaDigitos (x : xs) = x + somaDigitos xs

{--
 (d) Utilize as funções criadas anteriormente para definir a função
 luhn :: Int-> Bool
 que verifica se o número é uma sequência válida para um cartão
 de crédito. Exemplos:
 > luhn 1784
 True
 > luhn 4783
 False
 > luhn 4012888888881881
 True
 > luhn 4012888888881882
 False
--}
luhn :: Int -> Bool
luhn x = somaDigitos (digitosDobrados (dobroAlternado (digitosRev x))) `mod` 10 == 0

{--
main
--}
main :: IO ()
main = do
  print (show (penultimo ([1, 2, 3, 4, 5] :: [Int])))
  print (show (luhn 4012888888881882))
  print (show (maximoLocal ([1, 2, 6, 4, 5] :: [Int])))
  print (show (perfeitos 500))
  print (show (produtoEscalar [1, 2, 3, 4, 5] [1, 2, 3, 4, 5] :: Integer))
  print (show (palindromo [1, 2, 3, 2, 1]))
  print (show (ordenaListas [[1, 2, 3, 4 :: Integer], [3, 4 :: Integer], [1, 2, 3 :: Integer]]))
  print (show (coordNested [1, 2, 3, 4 :: Integer] [5, 6, 7, 8 :: Integer]))
