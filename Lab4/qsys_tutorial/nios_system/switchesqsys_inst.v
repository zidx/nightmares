	switchesqsys u0 (
		.clk_clk                 (<connected-to-clk_clk>),                 //              clk.clk
		.reset_reset_n           (<connected-to-reset_reset_n>),           //            reset.reset_n
		.switches_export         (<connected-to-switches_export>),         //         switches.export
		.leds_export             (<connected-to-leds_export>),             //             leds.export
		.readytodownload1_export (<connected-to-readytodownload1_export>), // readytodownload1.export
		.outsignal_export        (<connected-to-outsignal_export>),        //        outsignal.export
		.curbyte1_export         (<connected-to-curbyte1_export>),         //         curbyte1.export
		.readytodownload2_export (<connected-to-readytodownload2_export>), // readytodownload2.export
		.curbyte2_export         (<connected-to-curbyte2_export>)          //         curbyte2.export
	);

