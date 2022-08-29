/// An element which allows the user to switch between multiple
/// [frames](ZF_Frame) by clicking on tabs.
///
/// Tabs should be added to the element via [`addTab`] after creation.
class wos_ZF_Tabs : wos_ZF_ElementContainer {
	private void config(
		double tabHeight, double tabLabelMargin, Font tabFont = NULL, double tabTextScale = 1.0,
		wos_ZF_BoxTextures tabNormal = NULL, wos_ZF_BoxTextures tabHover = NULL, wos_ZF_BoxTextures tabActive = NULL
	) {
		self.setBoxes = false;

		setTabHeight(tabHeight);
		setTabLabelMargin(tabLabelMargin);
		setTabFont(tabFont);
		setTabTextScale(tabTextScale);
		setTabNormalTexture(tabNormal);
		setTabHoverTexture(tabHover);
		setTabActiveTexture(tabActive);
		setAlpha(1.0);

		self.setBoxes = true;

		setTabLabelBoxes();
	}

	/// Returns a newly created tabs element.
	///
	/// The position used is relative to whatever the element is packed into
	/// later.
	///
	/// The tabs section of the element will have height `tabHeight`, with tab
	/// buttons with `tabLabelMargin` pixels of space between the text and
	/// borders (horizontally).
	///
	/// If `tabFont` is `NULL`, then `smallfont` is used instead.
	///
	/// The background for inactive tabs is `tabNormal`, with the background
	/// for active tabs being `tabActive`. When an inactive tab is hovered, it
	/// will use `tabHover` instead.
	///
	/// After creation, [`addTab`] should be used to add tabs.
	static wos_ZF_Tabs create(
		Vector2 pos, Vector2 size,
		double tabHeight, double tabLabelMargin, Font tabFont = NULL, double tabTextScale = 1.0,
		wos_ZF_BoxTextures tabNormal = NULL, wos_ZF_BoxTextures tabHover = NULL, wos_ZF_BoxTextures tabActive = NULL
	) {
		let ret = new("wos_ZF_Tabs");

		ret.setBox(pos, size);
		ret.curTab = new("wos_ZF_RadioController");
		ret.config(tabHeight, tabLabelMargin, tabFont, tabTextScale, tabNormal, tabHover, tabActive);

		return ret;
	}

	private Array<wos_ZF_RadioButton> tabLabels;
	private Array<wos_ZF_Frame> tabFrames;
	private wos_ZF_RadioController curTab;

	private double tabHeight;
	/// Returns the height of the tabs section.
	double getTabHeight() { return self.tabHeight; }
	/// Sets the height of the tabs section;
	void setTabHeight(double tabHeight) { self.tabHeight = tabHeight; setTabLabelBoxes(); }

	private double tabLabelMargin;
	/// Returns the horizontal margin between tab buttons and their boxes'
	/// borders.
	double getTabLabelMargin() { return self.tabLabelMargin; }
	/// Sets the horizontal margin between tab buttons and their boxes'
	/// borders.
	void setTabLabelMargin(double tabLabelMargin) { self.tabLabelMargin = tabLabelMargin; setTabLabelBoxes(); }

	private Font tabFont;
	/// Returns the font the tab buttons will use for drawing their text.
	Font getTabFont() { return self.tabFont; }
	/// Returns the font the tab buttons will use for drawing their text.
	///
	/// If this is `NULL`, then `smallfont` is used instead.
	void setTabFont(Font tabFont) {
		if (tabFont == NULL) {
			self.tabFont = smallfont;
		}
		else {
			self.tabFont = tabFont;
		}
		setTabLabelBoxes();
	}

	private double tabTextScale;
	/// Returns the scaling factor for the drawn tab button text.
	double getTabTextScale() { return self.tabTextScale; }
	/// Sets the scaling factor for the drawn tab button text.
	void setTabTextScale(double tabTextScale) { self.tabTextScale = tabTextScale; setTabLabelBoxes(); }

	private wos_ZF_BoxTextures tabNormal;
	/// Returns the box textures used for an inactive, unhovered tab.
	wos_ZF_BoxTextures getTabNormalTexture() { return self.tabNormal; }
	/// Sets the box textures used for an inactive, unhovered tab.
	void setTabNormalTexture(wos_ZF_BoxTextures tabNormal) { self.tabNormal = tabNormal; setTabLabelBoxes(); }

	private wos_ZF_BoxTextures tabHover;
	/// Returns the box textures used for an inactive, hovered tab.
	wos_ZF_BoxTextures getTabHoverTexture() { return self.tabHover; }
	/// Sets the box textures used for an inactive, hovered tab.
	void setTabHoverTexture(wos_ZF_BoxTextures tabHover) { self.tabHover = tabHover; setTabLabelBoxes(); }

	private wos_ZF_BoxTextures tabActive;
	/// Returns the box textures used for an active tab.
	wos_ZF_BoxTextures getTabActiveTexture() { return self.tabActive; }
	/// Sets the box textures used for an active tab.
	void setTabActiveTexture(wos_ZF_BoxTextures tabActive) { self.tabActive = tabActive; setTabLabelBoxes(); }

	private uint tabFocus;

	private int lastTab;

	private bool setBoxes;
	private void setTabLabelBoxes() {
		if (setBoxes) {
			double curX = 0.0;
			for (int i = 0; i < tabLabels.size(); i++) {
				let l = tabLabels[i];
				l.setBox((curX, 0.0), (tabFont.stringWidth(l.getText()) * tabTextScale + 2.0 * tabLabelMargin, tabHeight));
				l.config(curTab, i, tabNormal, tabHover, tabActive, NULL, l.getText(), tabFont, tabTextScale);
				curX += l.box.size.x;
			}
		}
	}
	
	override void getFocusAABB(wos_ZF_AABB box) {
		let label = tabLabels[tabFocus];
		box.pos = label.relToMainFrame((0, 0));
		box.size = label.box.size;
	}

	override void beenFocused(wos_ZF_NavEventType type) {
		switch (type) {
		case wos_ZF_NavEventType_Left: tabFocus = tabLabels.size() - 1; break;

		case wos_ZF_NavEventType_Right:
		case wos_ZF_NavEventType_Tab:
			tabFocus = 0; break;

		case wos_ZF_NavEventType_Down:
		case wos_ZF_NavEventType_Up:
			tabFocus = curTab.curVal; break;
		}
	}

	private void showCorrectTab() {
		for (int i = 0; i < tabFrames.size(); i++) {
			if (i == curTab.curVal) { tabFrames[i].show(); }
			else { tabFrames[i].hide(); }
		}
	}

	/// Adds a tab to the element, with `label` displayed on the button.
	///
	/// After addition, the tab frame can be modified by getting it from
	/// [`getTabFrame`].
	void addTab(string label) {
		let button = wos_ZF_RadioButton.create((0, 0), (0, 0), curTab, 0, text: label);
		let frame = wos_ZF_Frame.create((0.0, tabHeight), (box.size.x, box.size.y - tabHeight));

		button.master = self;
		frame.master = self;

		elements.push(button);
		elements.push(frame);

		tabLabels.push(button);
		tabFrames.push(frame);

		setTabLabelBoxes();

		showCorrectTab();
	}

	/// Returns the tab frame at the given index.
	wos_ZF_Frame getTabFrame(int index) {
		return tabFrames[index];
	}

	override void topDrawer() {
		if (curTab.curVal != lastTab) {
			lastTab = curTab.curVal;
			showCorrectTab();
		}
		Super.topDrawer();
	}

	override void drawer() {
		if (curTab.curVal != lastTab) {
			lastTab = curTab.curVal;
			showCorrectTab();
		}
		Super.drawer();
	}

	override bool onNavEvent(wos_ZF_NavEventType type, bool fromController) {
		if (isFocused() && isEnabled()) {
			switch (type) {
			case wos_ZF_NavEventType_Right:
				if (tabFocus != tabLabels.size() - 1) {
					tabFocus += 1;
					return true;
				}
				break;
			case wos_ZF_NavEventType_Left:
				if (tabFocus != 0) {
					tabFocus -= 1;
					return true;
				}
				break;
			case wos_ZF_NavEventType_Confirm:
				curTab.curVal = tabFocus;
				break;
			}
		}
		return Super.onNavEvent(type, fromController);
	}

}
