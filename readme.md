# Init systemC project script

## About

This cript will clone some written files (.cpp .h Makefile) for making a SystemC prject quicker and run easier :>

## Demo

<pre><font color="#26A269"><b>ngxxfus@ngxxfus-X409FA </b></font><font color="#12488B"><b>[15:56:35] </b></font><font color="#D0CFCC">[FS-4BIT]</font> <font color="#26A269">[master]</font>
<font color="#12488B"><b> $ </b></font>systemc_init                                                                             
<font color="#2A7BDE"><b>1. Enter the *cpp filename (w/o space(s))</b></font>
E.g: &apos;hehe&apos; NOT &apos;he he.cpp&apos;

<b>FILENAME</b>=fs 4bit

<b>NEW_FILENAME=</b><font color="#A2734C"><b>FS_4BIT</b></font>

<font color="#2A7BDE"><b>2. Make HELLOWORLD FS_4BIT.cpp file...</b></font>
<font color="#A2734C">W</font>: <u style="text-decoration-style:solid">FS_4BIT.h</u>
#ifndef __FS_4BIT_H__
#define __FS_4BIT_H__
/// put your module here !!
/// put your module here !!
/// put your module here !!
#endif
<font color="#A2734C">W</font>: <u style="text-decoration-style:solid">FS_4BIT.cpp</u>
#include &lt;systemc.h&gt;

#ifndef SC_TRACE
	#define sc_set_trace(obj) sc_trace(trace_file, obj, obj.name());
#endif

#ifndef rev
	#define rev(i, n) for(int i = n-1; i &gt;= 0; i--)
#endif

#ifndef var_print /// variadic print
	#define var_print
	template&lt;class T&gt; void print(T what){cout &lt;&lt; what;}
	template&lt;class T, class... Args&gt; void print(T what, Args... args){
		cout &lt;&lt; what;
		print(args...);
	}
#endif

#ifndef _mono_pulse
	#define _mono_pulse
	void mono_pulse(sc_signal&lt;bool&gt; &amp;pulse){
		pulse.write(0);
		sc_start(5, SC_NS);
		pulse.write(1);
		sc_start(5, SC_NS);
		pulse.write(0);
	};
#endif

int sc_main(int argc, char* argv[]) {
	

	sc_trace_file* trace_file = 
	sc_create_vcd_trace_file(&quot;wavetrace_output&quot;);
	trace_file-&gt;set_time_unit(1, SC_NS);

	cout &lt;&lt; &quot;Start sim...\n&quot;;

	cout &lt;&lt; &quot;\nFinished!\n&quot;;
        sc_close_vcd_trace_file(trace_file);
	return 0;
}


<font color="#2A7BDE"><b>3. Clone Makefile into the project...</b></font>
######################## SYSTEMC MAKEFILE ##########################
# Please change SRC (your input *.cpp file)                        #
####################################################################

#! /bin/zsh

SRC=FS_4BIT.cpp

OBJ = $(SRC:.cpp=.o)
OUT = $(basename $(firstword $(SRC)))
CXX = g++
CXXFLAGS = -I. -I$(SYSTEMC_HOME)/include
LDFLAGS = -L. -L$(SYSTEMC_HOME)/lib -Wl,-rpath=$(SYSTEMC_HOME)/lib
LDLIBS = -lsystemc -lm
all: $(OUT)

$(OUT): $(OBJ)
	$(CXX) -o $@ $^ $(LDFLAGS) $(LDLIBS)

%.o: %.cpp
	$(CXX) $(CXXFLAGS) -c $&lt; -o $@

clean:
	rm -f $(OBJ) $(OUT)

exec:
	./$(OUT)
	gtkwave -S gtkwave.tcl &amp;

####################################################################
#                                                                  #
####################################################################

4. Clone gtkwave.tcl into the project...
gtkwave::loadFile &quot;wavetrace_output.vcd&quot;
set num_sigs [gtkwave::getNumFacs]
for {set i 0} {$i &lt; $num_sigs} {incr i} {
    set sig_name [gtkwave::getFacName $i]
    gtkwave::addSignalsFromList $sig_name
}
gtkwave::setZoomFactor -2

<font color="#2A7BDE"><b>DONE!</b></font> Check `SRC` in <b>Makefile</b> file and change if needed\!
<font color="#26A269"><b>ngxxfus@ngxxfus-X409FA </b></font><font color="#12488B"><b>[15:57:00] </b></font><font color="#D0CFCC">[FS-4BIT]</font> <font color="#26A269">[master </font><font color="#C01C28">*</font><font color="#26A269">]</font>
<font color="#12488B"><b> $ </b></font>ls
<font color="#26A269"><b>FS_4BIT.cpp</b></font>  <font color="#26A269"><b>FS_4BIT.h</b></font>  <font color="#26A269"><b>gtkwave.tcl</b></font>  <font color="#26A269"><b>Makefile</b></font>
<font color="#26A269"><b>ngxxfus@ngxxfus-X409FA </b></font><font color="#12488B"><b>[15:58:23] </b></font><font color="#D0CFCC">[FS-4BIT]</font> <font color="#26A269">[master </font><font color="#C01C28">*</font><font color="#26A269">]</font>
<font color="#12488B"><b> $ </b></font>cat FS_4BIT.h
#ifndef __FS_4BIT_H__
#define __FS_4BIT_H__
/// put your module here !!
/// put your module here !!
/// put your module here !!
#endif
<font color="#26A269"><b>ngxxfus@ngxxfus-X409FA </b></font><font color="#12488B"><b>[15:58:36] </b></font><font color="#D0CFCC">[FS-4BIT]</font> <font color="#26A269">[master </font><font color="#C01C28">*</font><font color="#26A269">]</font>
<font color="#12488B"><b> $ </b></font>cat FS_4BIT.cpp
#include &lt;systemc.h&gt;

#ifndef SC_TRACE
	#define sc_set_trace(obj) sc_trace(trace_file, obj, obj.name());
#endif

#ifndef rev
	#define rev(i, n) for(int i = n-1; i &gt;= 0; i--)
#endif

#ifndef var_print /// variadic print
	#define var_print
	template&lt;class T&gt; void print(T what){cout &lt;&lt; what;}
	template&lt;class T, class... Args&gt; void print(T what, Args... args){
		cout &lt;&lt; what;
		print(args...);
	}
#endif

#ifndef _mono_pulse
	#define _mono_pulse
	void mono_pulse(sc_signal&lt;bool&gt; &amp;pulse){
		pulse.write(0);
		sc_start(5, SC_NS);
		pulse.write(1);
		sc_start(5, SC_NS);
		pulse.write(0);
	};
#endif

int sc_main(int argc, char* argv[]) {
	

	sc_trace_file* trace_file = 
	sc_create_vcd_trace_file(&quot;wavetrace_output&quot;);
	trace_file-&gt;set_time_unit(1, SC_NS);

	cout &lt;&lt; &quot;Start sim...\n&quot;;

	cout &lt;&lt; &quot;\nFinished!\n&quot;;
        sc_close_vcd_trace_file(trace_file);
	return 0;
}

<font color="#26A269"><b>ngxxfus@ngxxfus-X409FA </b></font><font color="#12488B"><b>[15:58:43] </b></font><font color="#D0CFCC">[FS-4BIT]</font> <font color="#26A269">[master </font><font color="#C01C28">*</font><font color="#26A269">]</font>
<font color="#12488B"><b> $ </b></font>cat Makefile
######################## SYSTEMC MAKEFILE ##########################
# Please change SRC (your input *.cpp file)                        #
####################################################################

#! /bin/zsh

SRC=FS_4BIT.cpp

OBJ = $(SRC:.cpp=.o)
OUT = $(basename $(firstword $(SRC)))
CXX = g++
CXXFLAGS = -I. -I$(SYSTEMC_HOME)/include
LDFLAGS = -L. -L$(SYSTEMC_HOME)/lib -Wl,-rpath=$(SYSTEMC_HOME)/lib
LDLIBS = -lsystemc -lm
all: $(OUT)

$(OUT): $(OBJ)
	$(CXX) -o $@ $^ $(LDFLAGS) $(LDLIBS)

%.o: %.cpp
	$(CXX) $(CXXFLAGS) -c $&lt; -o $@

clean:
	rm -f $(OBJ) $(OUT)

exec:
	./$(OUT)
	gtkwave -S gtkwave.tcl &amp;

####################################################################
#                                                                  #
####################################################################

<font color="#26A269"><b>ngxxfus@ngxxfus-X409FA </b></font><font color="#12488B"><b>[15:58:53] </b></font><font color="#D0CFCC">[FS-4BIT]</font> <font color="#26A269">[master </font><font color="#C01C28">*</font><font color="#26A269">]</font>
<font color="#12488B"><b> $ </b></font>
</pre>
