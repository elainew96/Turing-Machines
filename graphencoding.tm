
states:          q,s,q1,q2,q3,qA,qR
input_alphabet:  $,1,2,3,4,:,|
tape_alphabet:   $,a,b,c,d,_,:,|,1,2,3,4
start_state:     q
accept_state:    qA
reject_state:    qR
delta:           q,$____ -> s,$aaaa,RSSSS
                 s,1???? -> q1,1b???,RSSSS
                 s,2???? -> q2,2cc??,RSSSS
                 s,3???? -> q3,3ddd?,RSSSS
                 s,_???? -> qA,_????,SSSSS
                 s,|???? -> s,|c???,RSSSS
                 q1,:???? -> q1,:????,RSSSS
                 q1,2ba?? -> s,2bbaa,RSSSS
                 q1,3b?a? -> s,3bbba,RSSSS
                 q1,4b??a -> s,4bbbb,RSSSS
                 q2,:???? -> q2,:????,RSSSS
                 q2,3cca? -> s,3ccca,RSSSS
                 q2,3ccb? -> s,3ccca,RSSSS
                 q2,4cc?a -> s,4cccc,RSSSS
                 q2,4cc?b -> s,4cccc,RSSSS
                 q3,:???? -> q3,:????,RSSSS
                 q3,4ddd? -> s,4dddd,RSSSS
