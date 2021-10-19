proc h {} {
    echo "================================================="
    echo "h                 -- display this message"
    echo "up                -- update script"
    echo "all               -- compile all"
    echo "all               -- compile all"
    echo "sim               -- start simulation"
    echo "runa              -- run simulation"
    echo "simr              -- start simulation and run"
    echo "aresr             -- compile all, restart"
    echo "================================================="
  }

proc up {} {
    source make.tcl
  }

proc all {} {
    vlog -sv my_if.sv
    vlog -sv my_pkg.sv

    vlog -sv top.sv
  }

proc sim {} {
    vsim -novopt +UVM_TESTNAME=my_test top
  }

proc runa {} {
    onbreak {resume}
    run -all
  }

proc simr {} {
    sim
    runa
  }

proc aresr {} {
    all
    restart -f
    runa
  }

h
