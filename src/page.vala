namespace Keyboard
{
	// a common class for all pages
	public abstract class AbstractPage : Gtk.Grid
	{
		public abstract string title {get; protected set;}
		
		public AbstractPage ()
		{
			this.row_spacing    = 12;
			this.column_spacing = 12;
			this.margin_top     = 12;
			this.margin_bottom  = 12;
			this.column_homogeneous = false;
			this.row_homogeneous    = false;
		}
		
		// every page must provide a class to reset all settings to default
		public abstract void reset ();
	}
}
