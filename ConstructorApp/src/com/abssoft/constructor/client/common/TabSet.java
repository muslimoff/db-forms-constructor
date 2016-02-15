package com.abssoft.constructor.client.common;

import com.abssoft.constructor.client.ConstructorApp;
import com.abssoft.constructor.client.common.FormTab.TabType;
import com.abssoft.constructor.client.data.Utils;
import com.abssoft.constructor.client.form.DetailFormsContainer;
import com.abssoft.constructor.client.form.MainFormContainer;
import com.abssoft.constructor.client.form.MainFormPane;
import com.google.gwt.core.client.JavaScriptObject;
import com.smartgwt.client.data.Criteria;
import com.smartgwt.client.data.Record;
import com.smartgwt.client.types.Side;
import com.smartgwt.client.widgets.Canvas;
import com.smartgwt.client.widgets.events.ClickEvent;
import com.smartgwt.client.widgets.events.ClickHandler;
import com.smartgwt.client.widgets.events.DrawEvent;
import com.smartgwt.client.widgets.events.DrawHandler;
import com.smartgwt.client.widgets.menu.Menu;
import com.smartgwt.client.widgets.menu.MenuItem;
import com.smartgwt.client.widgets.tab.Tab;
import com.smartgwt.client.widgets.tab.TabBar;
import com.smartgwt.client.widgets.tab.events.CloseClickHandler;
import com.smartgwt.client.widgets.tab.events.TabCloseClickEvent;
import com.smartgwt.client.widgets.tab.events.TabContextMenuEvent;
import com.smartgwt.client.widgets.tab.events.TabContextMenuHandler;
import com.smartgwt.client.widgets.tab.events.TabSelectedEvent;
import com.smartgwt.client.widgets.tab.events.TabSelectedHandler;
import com.smartgwt.client.widgets.toolbar.ToolStrip;
import com.smartgwt.client.widgets.toolbar.ToolStripButton;
import com.smartgwt.client.widgets.toolbar.ToolStripMenuButton;

/*
 * http://forums.smartclient.com/forum/smart-gwt-technical-q-a/4668-tabbar-controls
 * */
public class TabSet extends com.smartgwt.client.widgets.tab.TabSet {

	protected Criteria parentFormCriteriaIntrn = new Criteria();
	protected final String hideTabsetPanesButtonIconTemplate = "[SKIN]/headerIcons/double_arrow_&direction&_Over.png";
	private final int toolstripSize = 110;
	private Menu menu = new Menu();
	private ToolStripMenuButton menuButton = new ToolStripMenuButton("", menu);
	private ToolStrip toolStrip = new ToolStrip();

	// /удалитьна
	private ToolStripButton hideTabsetPanesButton = new ToolStripButton();
	private boolean isCollapsed = false;
	private String prevSizeAsString;
	protected String currentHideTabsetPanesButtonIcon;
	protected String prevHideTabsetPanesButtonIcon;

	// Оставитьна
	// ToolStripButton bUp = new ToolStripButton("", "[SKIN]/headerIcons/double_arrow_up_Over.png");
	// ToolStripButton bDown = new ToolStripButton("", "[SKIN]/headerIcons/double_arrow_down_Over.png");

	protected void showOrCollapse() {
		TabSet ts = TabSet.this;
		switch (ts.getTabBarPosition()) {
		case LEFT:
		case RIGHT:
			ts.setWidth(prevSizeAsString);
			if (isCollapsed()) {
			} else {
				prevSizeAsString = null != prevSizeAsString ? prevSizeAsString
						: (null != ts.getWidthAsString() ? ts.getWidthAsString() : "100%");
				ts.setWidth(24);
			}
			break;
		default: // case TOP: case BOTTOM:
			ts.setHeight(prevSizeAsString);
			if (isCollapsed()) {
			} else {
				prevSizeAsString = null != prevSizeAsString ? prevSizeAsString
						: (null != ts.getHeightAsString() ? ts.getHeightAsString() : "100%");
				ts.setHeight(24);
			}
			break;
		}

	}

	protected void setHideTabsetPanesButtonIcons(Side tabBarPosition) {
		String icon;
		String prevIcon;
		switch (tabBarPosition) {
		case BOTTOM:
			icon = "up";
			prevIcon = "down";
			break;
		case LEFT:
			icon = "right";
			prevIcon = "left";
			break;
		case RIGHT:
			icon = "left";
			prevIcon = "right";
			break;
		default: // TOP
			icon = "down";
			prevIcon = "up";
		}
		currentHideTabsetPanesButtonIcon = hideTabsetPanesButtonIconTemplate.replace("&direction&", icon);
		prevHideTabsetPanesButtonIcon = hideTabsetPanesButtonIconTemplate.replace("&direction&", prevIcon);
	}

	@Override
	public void setTabBarPosition(Side tabBarPosition) throws IllegalStateException {
		super.setTabBarPosition(tabBarPosition);
		String menuTitle = "";
		ToolStrip tstrip = getToolStrip();
		switch (tabBarPosition) {
		case LEFT:
			break;
		case RIGHT:
			tstrip.setVertical(true);
			tstrip.setHeight(toolstripSize);
			tstrip.setWidth(24);
			break;
		default: // TOP or BOTTOM
			tstrip.setHeight(24);
			tstrip.setWidth(toolstripSize);
			menuTitle = "Действия";
		}
		tstrip.addMenuButton(menuButton);
		tstrip.addSeparator();
		setHideTabsetPanesButtonIcons(tabBarPosition);
		hideTabsetPanesButton.setIcon(currentHideTabsetPanesButtonIcon);
		hideTabsetPanesButton.setIconSize(15);
		hideTabsetPanesButton.setTooltip("Скрыть/показать");
		menuButton.setTitle(menuTitle);

		hideTabsetPanesButton.addClickHandler(new ClickHandler() {
			@Override
			public void onClick(ClickEvent event) {
				showOrCollapse();
				currentHideTabsetPanesButtonIcon = prevHideTabsetPanesButtonIcon;
				prevHideTabsetPanesButtonIcon = hideTabsetPanesButton.getIcon();
				hideTabsetPanesButton.setIcon(currentHideTabsetPanesButtonIcon);
				setCollapsed(!isCollapsed());
			}
		});

		// /
		// bUp.setIconSize(15);
		// bDown.setIconSize(15);
		//
		// bUp.addClickHandler(new ClickHandler() {
		// @Override
		// public void onClick(ClickEvent event) {
		// doUpAction();
		// }
		// });
		//
		// bDown.addClickHandler(new ClickHandler() {
		// @Override
		// public void onClick(ClickEvent event) {
		// doDownAction();
		// }
		// });
		// toolStrip.addButton(bUp);
		// toolStrip.addButton(bDown);
		getToolStrip().addButton(hideTabsetPanesButton);
		// this.setTabBarControls(TabBarControls.TAB_SCROLLER, TabBarControls.TAB_PICKER, toolStrip);
	}

	protected void doUpAction() {
		// TODO Auto-generated method stub

	}

	protected void doDownAction() {
		// TODO Auto-generated method stub

	}

	public TabSet() {
		super();

		// Показать тулстрип при первой отрисовке табсета.
		this.addDrawHandler(new DrawHandler() {

			@Override
			public void onDraw(DrawEvent event) {
				TabBar tbar = getTabBar();
				tbar.addChild(toolStrip);
				ConstructorApp.getActionsMenuBtn().setSubmenu(menu);
			}
		});

		addCloseClickHandler(new CloseClickHandler() {
			public void onCloseClick(TabCloseClickEvent event) {
				try {
					removeMainFormContainerTab(event.getTab(), true);
				} catch (Exception e) {
					e.printStackTrace();
					Utils.logException(e, "com.abssoft.constructor.client.common.TabSet.removeMainFormContainerTab");
				}
			}
		});
		addTabSelectedHandler(new TabSelectedHandler() {

			@Override
			public void onTabSelected(TabSelectedEvent event) {
				if (event.getTab() instanceof FormTab) {
					FormTab ft = ((FormTab) event.getTab());
					Utils.debug(ft.getFormCode() + "<<");

					MainFormPane mfp = ft.getMainFormPane();

					String tabType = ft.getTabMetaData().getTabType();
					if ((TabType.DETAIL.getValue().equals(tabType) || TabType.DYNAMIC_DETAIL_SINGLE.getValue().equals(tabType))
							&& TabSet.this instanceof DetailFormsContainer) {
						mfp.filterData(((DetailFormsContainer) TabSet.this).parentFormCriteriaIntrn, false);
					}

					ConstructorApp.mainToolBar.setForm(mfp);
				}
			}
		});
		// 20120812 - менюшко на табсете
		this.addTabSelectedHandler(new TabSelectedHandler() {

			@Override
			public void onTabSelected(TabSelectedEvent event) {
				setTabSetContextMenu(event.getTab());
			}
		});

		// 20120812 - Добавил контекстное меню для табика
		this.addTabContextMenuHandler(new TabContextMenuHandler() {

			@Override
			public void onTabContextMenu(TabContextMenuEvent event) {
				//
				MainFormPane mfp = (event.getTab() instanceof FormTab) ? ((FormTab) event.getTab()).getMainFormPane() : null;
				if (null != mfp) {
					Utils.debugAlert("TabContextMenuHandler:" //
							+ "\nThisFormCriteria:" + mfp.getThisFormCriteria().getValues() //
							+ "\nParentFormCriteria:" + mfp.getParentFormCriteria().getValues() //
							+ "\nPrevParentFormCriteria" + mfp.getPrevParentFormCriteria().getValues() //
					);
				}
				//

				try {
					TabSet.this.setContextMenu(event.getTab().getPane().getContextMenu());
					// Utils.debugAlert("!" + TabSet.this.getContextMenu());
				} catch (Exception e) {
					Utils.logException(e, "Error in com.abssoft.constructor.client.common.TabSet - TabContextMenuEvent" + e.getMessage());
					TabSet.this.setContextMenu(null);

				}
			}
		});

		// 20120820 - добавление меню - при нажатии, когда при активации таба менюшка была еще пуста. Блин, когда ж разберусь с эвентами..
		menuButton.addClickHandler(new ClickHandler() {

			@Override
			public void onClick(ClickEvent event) {
				// if (0 == menuButton.getMenu().getItems().length) {
				setTabSetContextMenu(TabSet.this.getSelectedTab());
				// }

			}
		});

		// this.setBackgroundColor("red");
		// this.setBackgroundImage("[SKIN]/shared/background.png");
		// this.setBackgroundRepeat(BkgndRepeat.REPEAT_X);
		// this.setBackgroundPosition("bottom left scroll");
		// this.setStyleName("buttonDisabled");
		// this.setBackgroundImage("[SKIN]ListGrid/header_Selected.png");
		// this.setBackgroundColor(menuButton.getBackgroundColor());
		// this.setStyleName("headerButton");
		// this.setBackgroundImage("");
		this.setBackgroundColor("#f0f0f0"); // Запарился - херь со стилями. Привинтил гвоздями серенький...

		JavaScriptObject jso = setTabBarLayoutStartMargin(toolstripSize + 5);
		this.setAttribute("tabBarProperties", jso, true);

		//
		//this.getPaneContainer().setMargin(50);
		this.setPaneMargin(1);
	}

	//Offsets the TabBar start position to give room for a button 
	private JavaScriptObject setTabBarLayoutStartMargin(int offset) {
		Record rec = new Record();
		rec.setAttribute("layoutStartMargin", offset);
		JavaScriptObject jso = rec.getJsObj();
		return jso;
	}

	public MenuItem[] getContextMenuParent(Canvas c) {
		MenuItem[] result = null;
		if (null != c) {
			if (null != c.getContextMenu()) {
				result = c.getContextMenu().getItems();
			} else {
				//Canvas parent = c.getParentElement();
				Canvas parent = c.getParentCanvas();
				if (null != parent) {
					result = getContextMenuParent(parent);
				}
			}
		}
		return result;
	}

	public void setTabSetContextMenu(Tab tab) {
		String title = null;
		MenuItem[] ctxMenuItems = null;
		if (null != tab) {
			title = tab.getTitle();
			if (null != tab.getPane()) {
				ctxMenuItems = getContextMenuParent(tab.getPane());
			}
		}
		menu.setItems(ctxMenuItems);
		menuButton.setTooltip(title);
	}

	public void selectTab(MainFormPane mainFormPane) {
		for (Tab t : this.getTabs()) {
			if (t.getPane() instanceof MainFormPane && mainFormPane.equals(t.getPane())) {
				this.selectTab(t);
				break;
			}
		}
	}

	public void removeMainFormContainerTab(Tab tab, boolean isFromTabsetCloseClickEvent) {

		if (tab instanceof MainFormContainer) {
			MainFormContainer t = (MainFormContainer) tab;
			Utils.debug("TabSet.removeMainFormContainerTab. Tab: " + t.getFormCode());
			t.getMainFormPane().doBeforeClose();
			// this.removeTab(tab.getID());
			try {
				// tab.getPane().destroy();
				Utils.debug("TabSet.removeMainFormContainerTab. 1");

				// Uncaught JavaScript exception [_9 is undefined] in
				// http://127.0.0.1:8888/constructorapp/sc/modules/ISC_Containers.js?isc_version=8.2.js, line 471
				// Закоментировано удаление табика (работает нормально и так) в связи с ошибкой (выше) и некорректном
				// открытии новых форм после закрытия (новая форма встравивалась в низ предыдущей):
				// this.removeTab(tab);

				// 20120501 Добарываю косяк при переходе на 3.0 - в случае, если по событию из табсета - не вызываем. Из-за косяка выше
				if (!isFromTabsetCloseClickEvent) {
					this.removeTab(tab);
				}
				Utils.debug("TabSet.removeMainFormContainerTab. 2");
			} catch (Exception e) {
				e.printStackTrace();
				Utils.logException(e, "com.abssoft.constructor.client.common.TabSet.removeMainFormContainerTab");
			}
			Utils.debug("TabSet.removeMainFormContainerTab. 3");
			ConstructorApp.mainToolBar.clear();
			Utils.debug("TabSet.removeMainFormContainerTab. 4");
		}
	}

	public void hideTabBar() {
		TabBar tbar = getTabBar();
		tbar.setHeight(0);
		tbar.hide();
	}

	public void setCollapsed(boolean isCollapsed) {
		this.isCollapsed = isCollapsed;
	}

	public boolean isCollapsed() {
		return isCollapsed;
	}

	private ToolStrip getToolStrip() {
		return toolStrip;
	}

	public void setPrevSizeAsString(String prevSizeAsString) {
		this.prevSizeAsString = prevSizeAsString;
	}

	public String getPrevSizeAsString() {
		return this.prevSizeAsString;
	}
}
