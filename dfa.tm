#how many tapes?
#one for input initial and then start
#one for transition of first one
#one for transition of second one
#one for transition of third one
#one for accept states
#one for transitions
#one to mark when to go on a new tape

states:			 q0, qA, qR,
				 scan_past_start_state,
				 copy_transitions, copy_accept_states, copy_input_string, reset_tape_heads,
				 check_state_1, check_state_2, reset_transition_tape, check_for_accept_state
input_alphabet:	 a,b,$,0,1,2,|,:
tape_alphabet:	 a,b,c,d,e,w,x,$,0,1,2,|,:,_
start_state:	 q0
accept_state:	 qA
reject_state:	 qR
delta:	 # Initialize first tape to current state, second tape to transition table, third tape to accept states, fourth tape to input string
				 q0,$______ -> scan_past_start_state,$$$$$$$,RRRRRRR
				 q0,$$$$$$$ -> qA,$$$$$$$,SSSSSSS

				 scan_past_start_state,?______ -> scan_past_start_state,?______,RSSSSSS
				 scan_past_start_state,|______ -> copy_transitions,_______,RSSSSSS

         copy_transitions,0______ -> copy_transitions,_0_____,RRSSSSS
				 copy_transitions,1______ -> copy_transitions,_1_____,RRSSSSS
				 copy_transitions,2______ -> copy_transitions,_2_____,RRSSSSS
				 copy_transitions,:______ -> copy_transitions,______c,RSSSSSS
         copy_transitions,0_____c -> copy_transitions,_0____c,RRSSSSS
         copy_transitions,1_____c -> copy_transitions,_1____c,RRSSSSS
         copy_transitions,2_____c -> copy_transitions,_2____c,RRSSSSS
         copy_transitions,:_____c -> copy_transitions,______d,RSSSSSS

         copy_transitions,0_____d -> copy_transitions,__0___d,RSRSSSS
				 copy_transitions,1_____d -> copy_transitions,__1___d,RSRSSSS
				 copy_transitions,2_____d -> copy_transitions,__2___d,RSRSSSS
				 copy_transitions,:_____d -> copy_transitions,______e,RSSSSSS
         copy_transitions,0_____e -> copy_transitions,__0___e,RSRSSSS
         copy_transitions,1_____e -> copy_transitions,__1___e,RSRSSSS
         copy_transitions,2_____e -> copy_transitions,__2___e,RSRSSSS
         copy_transitions,:_____e -> copy_transitions,______w,RSSSSSS

         copy_transitions,0_____w -> copy_transitions,___0__w,RSSRSSS
         copy_transitions,1_____w -> copy_transitions,___1__w,RSSRSSS
         copy_transitions,2_____w -> copy_transitions,___2__w,RSSRSSS
         copy_transitions,:_____w -> copy_transitions,______x,RSSSSSS
         copy_transitions,0_____x -> copy_transitions,___0__x,RSSRSSS
         copy_transitions,1_____x -> copy_transitions,___1__x,RSSRSSS
         copy_transitions,2_____x -> copy_transitions,___2__x,RSSRSSS
         copy_transitions,:_____x -> copy_transitions,______x,RSSSSSS

				 copy_transitions,|_____x -> copy_accept_states,_______,RSSSSSS

         copy_accept_states,0______ -> copy_accept_states,____0__,RSSSRSS
         copy_accept_states,1______ -> copy_accept_states,____1__,RSSSRSS
         copy_accept_states,2______ -> copy_accept_states,____2__,RSSSRSS
         copy_accept_states,:______ -> copy_accept_states,____:__,RSSSRSS
         copy_accept_states,a______ -> copy_input_string,_____a_,RSSSSRS
         copy_accept_states,b______ -> copy_input_string,_____b_,RSSSSRS

         copy_input_string,a______ -> copy_input_string,_____a_,RSSSSRS
         copy_input_string,b______ -> copy_input_string,_____b_,RSSSSRS
				 copy_input_string,_______ -> reset_tape_heads,_______,LSSSSSS

         reset_tape_heads,??????? -> reset_tape_heads,???????,LLLLLLL
				 reset_tape_heads,$$$$$$$ -> reset_transition_tape,$$$$$$$,SSSSSRS

         reset_transition_tape,??????? -> reset_transition_tape,???????,LLLLLSL
         reset_transition_tape,$$$$$a$ -> check_state_1,$$$$$a$,RRRRSSS
         reset_transition_tape,$$$$$b$ -> check_state_1,$$$$$b$,RRRRSSS
         reset_transition_tape,$$$$$_$ -> check_for_accept_state,$$$$$_$,RSSSRSS

         check_state_1,00??$a$ -> reset_transition_tape,00??$a$,SSSSSRS
         check_state_1,01??$a$ -> reset_transition_tape,11??$a$,SSSSSRS
         check_state_1,02??$a$ -> reset_transition_tape,22??$a$,SSSSSRS
         check_state_1,0???$b$ -> check_state_2,0???$b$,SRSSSSS
         check_state_1,1?0?$a$ -> reset_transition_tape,0?0?$a$,SSSSSRS
         check_state_1,1?1?$a$ -> reset_transition_tape,1?1?$a$,SSSSSRS
         check_state_1,1?2?$a$ -> reset_transition_tape,2?2?$a$,SSSSSRS
         check_state_1,1???$b$ -> check_state_2,1???$b$,SSRSSSS
         check_state_1,2??0$a$ -> reset_transition_tape,0??0$a$,SSSSSRS
         check_state_1,2??1$a$ -> reset_transition_tape,1??1$a$,SSSSSRS
         check_state_1,2??2$a$ -> reset_transition_tape,2??2$a$,SSSSSRS
         check_state_1,2???$b$ -> check_state_2,2???$b$,SSSRSSS

         check_state_2,00??$b$ -> reset_transition_tape,00??$b$,SSSSSRS
         check_state_2,01??$b$ -> reset_transition_tape,11??$b$,SSSSSRS
         check_state_2,02??$b$ -> reset_transition_tape,22??$b$,SSSSSRS
         check_state_2,1?0?$b$ -> reset_transition_tape,0?0?$b$,SSSSSRS
         check_state_2,1?1?$b$ -> reset_transition_tape,1?1?$b$,SSSSSRS
         check_state_2,1?2?$b$ -> reset_transition_tape,2?2?$b$,SSSSSRS
         check_state_2,2??0$b$ -> reset_transition_tape,0??0$b$,SSSSSRS
         check_state_2,2??1$b$ -> reset_transition_tape,1??1$b$,SSSSSRS
         check_state_2,2??2$b$ -> reset_transition_tape,2??2$b$,SSSSSRS

         check_for_accept_state,0$$$0_$ -> qA,0$$$0_$,SSSSSSS
         check_for_accept_state,1$$$1_$ -> qA,1$$$1_$,SSSSSSS
         check_for_accept_state,2$$$2_$ -> qA,1$$$1_$,SSSSSSS
         check_for_accept_state,0$$$__$ -> qR,0$$$__$,SSSSSSS
         check_for_accept_state,1$$$__$ -> qR,1$$$__$,SSSSSSS
         check_for_accept_state,2$$$__$ -> qR,2$$$__$,SSSSSSS
         check_for_accept_state,??????? -> check_for_accept_state,???????,SSSSRSS
