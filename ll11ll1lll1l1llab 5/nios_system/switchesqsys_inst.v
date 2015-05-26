	switchesqsys u0 (
		.clk_clk                (<connected-to-clk_clk>),                //             clk.clk
		.reset_reset_n          (<connected-to-reset_reset_n>),          //           reset.reset_n
		.switches_export        (<connected-to-switches_export>),        //        switches.export
		.leds_export            (<connected-to-leds_export>),            //            leds.export
		.readytodownload_export (<connected-to-readytodownload_export>), // readytodownload.export
		.outsignal_export       (<connected-to-outsignal_export>),       //       outsignal.export
		.curbyteout_export      (<connected-to-curbyteout_export>),      //      curbyteout.export
		.instrobe_export        (<connected-to-instrobe_export>),        //        instrobe.export
		.load_export            (<connected-to-load_export>),            //            load.export
		.curbytein_export       (<connected-to-curbytein_export>),       //       curbytein.export
		.empty_export           (<connected-to-empty_export>)            //           empty.export
	);

