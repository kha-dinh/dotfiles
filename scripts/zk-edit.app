tell application "iTerm"
	activate
	
	-- close the first session
	terminate the first session of the first terminal
	
	-- make a new terminal
	set myterm to (make new terminal)
	
	-- talk to the new terminal
	tell myterm
		
		-- make a new session
		set mysession to (make new session at the end of sessions)
		
		-- set size
		set number of columns to 100
		set number of rows to 50
		
		-- talk to the session
		tell mysession
			
			-- set some attributes
			set name to "tcsh"
			set foreground color to "red"
			set background color to "blue"
			set transparency to "0.6"
			
			-- execute a command
			exec command "/bin/tcsh"
			
		end tell -- we are done talking to the session
		
		-- we are back to talking to the terminal
		
		-- launch a default shell in a new tab in the same terminal
		launch session "Default Session"
		
		-- launch a saved session from the addressbook.
		launch session "Root Shell"
		-- select the previous session
		select mysession
		-- get the tty name of a session
		set myttyname to the tty of the first session
		-- refer to a session by its tty/id
		tell session id myttyname
			set foreground color to "yellow"
		end tell
		
	end tell
	
	-- talk to the first terminal
	tell the first terminal
		
		-- launch a default shell in a new tab in the same terminal
		launch session "Default Session"
		
		tell the last session
			
			-- write some text
			write text "cd Projects/Cocoa/iTerm"
			-- write the contents of a file
			write contents of file "/path/to/file/"
			
		end tell
		
	end tell
	
	-- reposition window and name it
	set the bounds of the first window to {100, 100, 700, 700}
	set the name of the first window to "A Window Title"
	
end tell
