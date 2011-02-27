With t As
     (Select     Level As Id, 1 + Level As a, 2 + Level As b, 3 + Level As c, 4 + Level As d
            From DUAL
      Connect By Level < 10), t2 As
                             (Select Id, XMLELEMENT ("root", XMLCOLATTVAL (t.a, t.b, t.c, t.d)) As xmltmp
                                From t)
Select id, xmltmp
  From t2

