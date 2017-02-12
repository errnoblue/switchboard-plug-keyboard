namespace Pantheon.Keyboard.Behaviour {
	Behaviour.SettingsRepeat settings_repeat;
	Behaviour.SettingsBlink  settings_blink;

    class Page : Pantheon.Keyboard.AbstractPage {
        Settings gsettings_blink;
        Settings gsettings_repeat;

        public override void reset () {
            gsettings_blink.reset ("cursor-blink");
            gsettings_blink.reset ("cursor-blink-time");
            gsettings_blink.reset ("cursor-blink-timeout");

            gsettings_repeat.reset ("delay");
            gsettings_repeat.reset ("repeat");
            gsettings_repeat.reset ("repeat-interval");

            return;
        }

        public Page () {
			settings_repeat = new Behaviour.SettingsRepeat ();
			settings_blink  = new Behaviour.SettingsBlink  ();

            var label_repeat = new Gtk.Label (_("Repeat Keys:"));
            label_repeat.get_style_context ().add_class ("h4");

			var label_repeat_delay = new Gtk.Label (_("Delay:"));
			var label_repeat_speed = new Gtk.Label (_("Interval:"));
			var label_repeat_ms1   = new Gtk.Label (_("milliseconds"));
			var label_repeat_ms2   = new Gtk.Label (_("milliseconds"));

            var switch_repeat = new Gtk.Switch ();
            switch_repeat.halign = Gtk.Align.START;
            switch_repeat.valign = Gtk.Align.CENTER;

			var scale_repeat_delay = new Gtk.Scale.with_range (Gtk.Orientation.HORIZONTAL, 10, 1000, 1);
			var scale_repeat_speed = new Gtk.Scale.with_range (Gtk.Orientation.HORIZONTAL, 10, 100,  1);
			var spin_repeat_delay  = new Gtk.SpinButton.with_range (10, 1000, 1);
			var spin_repeat_speed  = new Gtk.SpinButton.with_range (10, 100,  1);

			label_repeat.halign       = Gtk.Align.END;
			label_repeat_delay.halign = Gtk.Align.END;
			label_repeat_speed.halign = Gtk.Align.END;
			label_repeat_ms1.halign   = Gtk.Align.START;
			label_repeat_ms2.halign   = Gtk.Align.START;

			// tweak other widgets
			scale_repeat_delay.hexpand    = true;
			scale_repeat_speed.hexpand    = true;
			scale_repeat_delay.draw_value = false;
			scale_repeat_speed.draw_value = false;

			// attach to this
			this.attach (label_repeat,       0, 0, 1, 1);
			this.attach (label_repeat_delay, 0, 1, 1, 1);
			this.attach (label_repeat_speed, 0, 2, 1, 1);
			this.attach (switch_repeat,      1, 0, 1, 1);
			this.attach (scale_repeat_delay, 1, 1, 1, 1);
			this.attach (scale_repeat_speed, 1, 2, 1, 1);
			this.attach (spin_repeat_delay,  2, 1, 1, 1);
			this.attach (spin_repeat_speed,  2, 2, 1, 1);
			this.attach (label_repeat_ms1,   3, 1, 1, 1);
			this.attach (label_repeat_ms2,   3, 2, 1, 1);

			// set values from settigns
			var double_delay = (double) settings_repeat.delay;
			var double_speed = (double) settings_repeat.repeat_interval;

			scale_repeat_delay.set_value (double_delay);
			scale_repeat_speed.set_value (double_speed);
			spin_repeat_delay.set_value  (double_delay);
			spin_repeat_speed.set_value  (double_speed);

			// connect signals
			scale_repeat_delay.value_changed.connect (() => {
				settings_repeat.delay = (uint) (spin_repeat_delay.adjustment.value = scale_repeat_delay.adjustment.value);
			} );

			scale_repeat_speed.value_changed.connect (() => {
				settings_repeat.repeat_interval = (uint) (spin_repeat_speed.adjustment.value = scale_repeat_speed.adjustment.value);
			} );

			spin_repeat_delay.value_changed.connect (() => {
				settings_repeat.delay = (uint) (scale_repeat_delay.adjustment.value = spin_repeat_delay.adjustment.value);
			} );

			spin_repeat_speed.value_changed.connect (() => {
				settings_repeat.repeat_interval = (uint) (scale_repeat_speed.adjustment.value = spin_repeat_speed.adjustment.value);
			} );

			settings_repeat.changed["delay"].connect (() => {
				scale_repeat_delay.adjustment.value = spin_repeat_delay.adjustment.value = (double) settings_repeat.delay;
			} );

			settings_repeat.changed["repeat-interval"].connect (() => {
				scale_repeat_speed.adjustment.value = spin_repeat_speed.adjustment.value = (double) settings_repeat.repeat_interval;
			} );

            var label_blink = new Gtk.Label (_("Cursor Blinking:"));
            label_blink.get_style_context ().add_class ("h4");
            label_blink.margin_top = 24;

			var label_blink_speed = new Gtk.Label (_("Speed:"));
			var label_blink_time  = new Gtk.Label (_("Duration:"));
			var label_blink_ms    = new Gtk.Label (_("milliseconds"));
			var label_blink_s     = new Gtk.Label (_("seconds"));

            var switch_blink = new Gtk.Switch ();
            switch_blink.halign = Gtk.Align.START;
            switch_blink.valign = Gtk.Align.CENTER;
            switch_blink.margin_top = 24;

			var scale_blink_speed = new Gtk.Scale.with_range (Gtk.Orientation.HORIZONTAL, 100, 2500, 10);
			var scale_blink_time  = new Gtk.Scale.with_range (Gtk.Orientation.HORIZONTAL, 1, 100, 1);
			var spin_blink_speed  = new Gtk.SpinButton.with_range (100, 2500, 10);
			var spin_blink_time   = new Gtk.SpinButton.with_range (1, 100, 1);

			label_blink.halign       = Gtk.Align.END;
			label_blink_time.halign  = Gtk.Align.END;
			label_blink_speed.halign = Gtk.Align.END;
			label_blink_ms.halign    = Gtk.Align.START;
			label_blink_s.halign     = Gtk.Align.START;

			// tweak other widgets
			scale_blink_speed.hexpand    = true;
			scale_blink_time.hexpand     = true;
			scale_blink_speed.draw_value = false;
			scale_blink_time.draw_value  = false;

			// attach to this
			this.attach (label_blink,       0, 3, 1, 1);
			this.attach (label_blink_speed, 0, 4, 1, 1);
			this.attach (label_blink_time,  0, 5, 1, 1);
			this.attach (switch_blink,      1, 3, 1, 1);
			this.attach (scale_blink_speed, 1, 4, 1, 1);
			this.attach (scale_blink_time,  1, 5, 1, 1);
			this.attach (spin_blink_speed,  2, 4, 1, 1);
			this.attach (spin_blink_time,   2, 5, 1, 1);
			this.attach (label_blink_ms,    3, 4, 1, 1);
			this.attach (label_blink_s,     3, 5, 1, 1);

			// set values from settings
			var double_blink_speed = (double) settings_blink.cursor_blink_time;
			var double_blink_time  = (double) settings_blink.cursor_blink_timeout;

			scale_blink_speed.set_value (double_blink_speed);
			scale_blink_time.set_value  (double_blink_time);
			spin_blink_speed.set_value  (double_blink_speed);
			spin_blink_time.set_value   (double_blink_time);

            gsettings_blink = new Settings ("org.gnome.desktop.interface");
            gsettings_blink.bind ("cursor-blink", switch_blink, "active", SettingsBindFlags.DEFAULT);

            gsettings_repeat = new Settings ("org.gnome.desktop.peripherals.keyboard");
            gsettings_repeat.bind ("repeat", switch_repeat, "active", SettingsBindFlags.DEFAULT);

            switch_blink.bind_property ("active", label_blink_speed, "sensitive", BindingFlags.DEFAULT);
            switch_blink.bind_property ("active", label_blink_time, "sensitive", BindingFlags.DEFAULT);
            switch_blink.bind_property ("active", scale_blink_speed, "sensitive", BindingFlags.DEFAULT);
            switch_blink.bind_property ("active", scale_blink_time, "sensitive", BindingFlags.DEFAULT);
            switch_blink.bind_property ("active", spin_blink_speed, "sensitive", BindingFlags.DEFAULT);
            switch_blink.bind_property ("active", spin_blink_time, "sensitive", BindingFlags.DEFAULT);

            switch_repeat.bind_property ("active", label_repeat_delay, "sensitive", BindingFlags.DEFAULT);
            switch_repeat.bind_property ("active", label_repeat_speed, "sensitive", BindingFlags.DEFAULT);
            switch_repeat.bind_property ("active", scale_repeat_delay, "sensitive", BindingFlags.DEFAULT);
            switch_repeat.bind_property ("active", scale_repeat_speed, "sensitive", BindingFlags.DEFAULT);
            switch_repeat.bind_property ("active", spin_repeat_delay, "sensitive", BindingFlags.DEFAULT);
            switch_repeat.bind_property ("active", spin_repeat_speed, "sensitive", BindingFlags.DEFAULT);

			// connect signals
			scale_blink_speed.value_changed.connect (() => {
				settings_blink.cursor_blink_time = (int) (spin_blink_speed.adjustment.value = scale_blink_speed.adjustment.value);
			} );

			scale_blink_time.value_changed.connect (() => {
				settings_blink.cursor_blink_timeout = (int) (spin_blink_time.adjustment.value = scale_blink_time.adjustment.value);
			} );

			spin_blink_speed.value_changed.connect (() => {
				settings_blink.cursor_blink_time = (int) (scale_blink_speed.adjustment.value = spin_blink_speed.adjustment.value);
			} );

			spin_blink_time.value_changed.connect (() => {
				settings_blink.cursor_blink_timeout = (int) (scale_blink_time.adjustment.value = spin_blink_time.adjustment.value);
			} );

			settings_blink.changed["cursor-blink-time"].connect (() => {
				scale_blink_speed.adjustment.value = spin_blink_speed.adjustment.value = (double) settings_blink.cursor_blink_time;
			} );

			settings_blink.changed["cursor-blink-timeout"].connect (() => {
				scale_blink_time.adjustment.value = spin_blink_time.adjustment.value = (double) settings_blink.cursor_blink_timeout;
			} );

			/** Test Settings **/

			var entry_test = new Gtk.Entry ();
            entry_test.margin_top = 24;
			entry_test.placeholder_text = (_("Type to test your settings…"));
			entry_test.hexpand = true;

			this.attach (entry_test, 1, 6, 1, 1);
		}
	}
}