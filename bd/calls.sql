CALL altaRestaurant (1, 'petito37@gordo', 'juncal tu mama', 'petito38', 'momo');
CALL altaPlato (1, 'que', 'almomo', 2, 1, TRUE);
CALL registrarCliente (1, 'alberto', 'a', 'elbostero69@', 'kieeee');
CALL altaPedido (1, '1999-11-11 00:00:00', 1, 1, 27, 10, 'malardo');
CALL altaMenuplato (28, 1, 1, 20);
SELECT gananciaResto (1,'1999-11-11 00:00:00','1999-11-11 00:00:02');
CALL altaVentaResto (2022, 5, 1, 20);

CALL Buscar('almomo');
