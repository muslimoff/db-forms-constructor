package com.abssoft.constructor.client.data;

import com.abssoft.constructor.client.ConstructorApp;
import com.abssoft.constructor.client.form.MainFormPane;
import com.abssoft.constructor.client.widgets.FormLookupComboboxItem;
import com.abssoft.constructor.client.widgets.GridComboBoxItem;
import com.abssoft.constructor.client.widgets.MyComboBoxItem;
import com.abssoft.constructor.common.metadata.ColumnAction;
import com.abssoft.constructor.common.metadata.FormColumnMD;
import com.abssoft.constructor.common.metadata.FormMD;
import com.smartgwt.client.data.Record;
import com.smartgwt.client.types.ListGridFieldType;
import com.smartgwt.client.types.TextMatchStyle;
import com.smartgwt.client.widgets.form.fields.FormItem;
import com.smartgwt.client.widgets.form.fields.TextAreaItem;
import com.smartgwt.client.widgets.grid.CellFormatter;
import com.smartgwt.client.widgets.grid.HoverCustomizer;
import com.smartgwt.client.widgets.grid.ListGridRecord;
import com.smartgwt.client.widgets.grid.events.ChangedEvent;
import com.smartgwt.client.widgets.grid.events.ChangedHandler;
import com.smartgwt.client.widgets.grid.events.EditorEnterEvent;
import com.smartgwt.client.widgets.grid.events.EditorEnterHandler;
import com.smartgwt.client.widgets.grid.events.EditorExitEvent;
import com.smartgwt.client.widgets.grid.events.EditorExitHandler;
import com.smartgwt.client.widgets.tree.TreeGridField;

public class FormTreeGridField extends TreeGridField {
	private MainFormPane mainFormPane;
	private int colNum;
	private FormColumnMD columnMD;
	private GridComboBoxItem gridComboBoxItem;

	class GridFieldChangedHandler implements ChangedHandler {
		String colName;

		GridFieldChangedHandler(String colName) {
			this.colName = colName;
		}

		// TODO Необоснованно вызывается для дат???
		@Override
		public void onChanged(ChangedEvent event) {
			Utils.debug("GridFieldChangedHandler.onChanged..." + event.getItem().getType());
			if ("boolean".equals(event.getItem().getType())) {
				getMainFormPane().getValuesManager().setValue(colName, "true".equals(event.getValue() + ""));
			} else if ("date".equals(event.getItem().getType())) {
				// System.out.println("c@@@@@@@@@event.getItem() xx..." + event.getItem().getValue());
				// System.out.println("c@@@@@@@@@event.getItem() dt..." + (java.util.Date) event.getItem().getValue());
				// System.out.println("c@@@@@@@@@event.getValue()yy..." + event.getValue());
				// System.out.println("c@@@@@@@@@event.getValue()DT..." + (java.util.Date) event.getValue());
				getMainFormPane().getValuesManager().setValue(colName, (java.util.Date) event.getValue());
			} else {
				getMainFormPane().getValuesManager().setValue(colName, event.getValue() + "");
			}
		}
	}

	private MyComboBoxItem cmbxItem = null;

	public FormTreeGridField(final MainFormPane mainFormPane, int colNum, final FormColumnMD c) {
		final String colName = c.getName();
		String lookupCode = c.getLookupCode();
		this.setMainFormPane(mainFormPane);
		this.setColNum(colNum);
		this.setColumnMD(c);
		this.setName(colName);
		this.setTitle(c.getDisplayName());
		this.setWidth(c.getDisplaySize());
		this.setFrozen(c.isFrozen());
		this.setShowHover(c.isShowHover());

		if (null != c.getHoverСolumnСode()) {
			this.setHoverCustomizer(new HoverCustomizer() {

				@Override
				public String hoverHTML(Object value, ListGridRecord record, int rowNum, int colNum) {
					String hover = null != record ? record.getAttribute(c.getHoverСolumnСode()) : null;
					return hover;
				}
			});
		}
		this.setPrompt(c.getDescription());
		if (!"Y".equals(c.getShowOnGrid())) {
			this.setHidden(true);
			this.setCanHide(ConstructorApp.debugEnabled); // Чтобы включить нельзя было
		}

		// При редактировании грида изменять и значения в редакторе

		this.addChangedHandler(new GridFieldChangedHandler(colName));

		// TODO - недорешил с исчезновением дат при выходе из нередактированного поля даты
		// //////////////Начало. Только для поиска проблемы захеривания дат \\\\\\\\\\\\\\\\\
		// this.addEditorEnterHandler(new EditorEnterHandler() {
		//
		// @Override
		// public void onEditorEnter(EditorEnterEvent event) {
		// System.out.println("a@@@@@@@@@event.getClass():" + event.getClass());
		// System.out.println("a@@@@@@@@@" + event.getValue());
		// }
		// });
		// this.addChangeHandler(new ChangeHandler() {
		//
		// @Override
		// public void onChange(ChangeEvent event) {
		// System.out.println("b@@@@@@@@@event.getClass():" + event.getClass());
		// System.out.println("b@@@@@@@@@" + event.getOldValue());
		// System.out.println("b@@@@@@@@@" + event.getValue());
		// }
		// });

		this.addEditorExitHandler(new EditorExitHandler() {

			@Override
			public void onEditorExit(EditorExitEvent event) {
				// try {
				// System.out.println("d@@@@@@@@@event.getClass():" + event.getClass());
				// System.out.println("d@@@@@@@@@ getNewValue:" + event.getNewValue());
				// // System.out.println("d@@@@@@@@@ getNewValue" + event.getValue());
				// int rowNum = event.getRowNum();
				// int colNum = event.getColNum();
				// String[] attributes = event.getRecord().getAttributes();
				// for (int i = 0; i < attributes.length; i++) {
				// System.out.println("xxxxxxxxx>>" + i + "=" + attributes[i] + "; " + event.getRecord().getAttribute(attributes[i]));
				// }
				// System.out.println("d@@@@@@@@@ attributes:" + attributes);
				// String colName = attributes[colNum];
				// System.out.println("d@@@@@@@@@ colName:" + colName);
				// System.out.println("d@@@@@@@@@ colVal:" + event.getRecord().getAttribute(colName));
				// System.out.println("d@@@@@@@@@ event.getSource:" + event.getSource());
				// ListGridFieldType fieldType = mainFormPane.getMainForm().getTreeGrid().getField(colNum).getType();
				// System.out.println("d@@@@@@@@@ fieldType:" + fieldType);
				// if ("date".equals(fieldType.getValue())) {
				// System.out.println("d@@@@@@@@@ colValDT:" + event.getRecord().getAttributeAsDate(colName));
				// }
				// System.out.println("d@@@@@@@@@ rowNum:" + rowNum);
				// System.out.println("d@@@@@@@@@>>>" + mainFormPane.getMainForm().getTreeGrid().getEditValue(rowNum, colNum));
				// } catch (Exception e) {
				// e.printStackTrace();
				// }
			}
		});
		// //////////////Конец. Только для поиска проблемы захеривания дат.. потом удалить \\\\\\\\\\\\\\\\\
		if ("N".equals(c.getDataType())) {
			this.setType(ListGridFieldType.FLOAT);

		}
		if ("D".equals(c.getDataType())) {
			// this.setDateFormatter(DateDisplayFormat.TOEUROPEANSHORTDATE);
		}
		// if ("S".equals(c.getDataType())) {
		// TreeGridField fff = new TreeGridField();
		// }
		if ("3".equals(c.getFieldType())) {
			this.setType(ListGridFieldType.IMAGE);
		} else if ("4".equals(c.getFieldType())) {
			this.setType(ListGridFieldType.TEXT);
			this.setEditorProperties(new TextAreaItem());

		} // CodeEditorItem
		else if ("15".equals(c.getFieldType())) {
			this.setType(ListGridFieldType.TEXT);
			// this.setEditorType(new CodeEditorItem());
			this.setEditorProperties(new TextAreaItem());

		}

		else if (("8".equals(c.getFieldType()) || "10".equals(c.getFieldType())) && null != lookupCode
				&& ConstructorApp.staticLookupsArr.containsKey(lookupCode)) {
			cmbxItem = new MyComboBoxItem(c, mainFormPane) {

				@Override
				public void onClearValue(FormItem item) {
				}
			};
			FormMD fmd = mainFormPane.getFormMetadata();
			((MyComboBoxItem) cmbxItem).setLookupSize(c.getLookupWidth(), c.getLookupHeight(), fmd.getLookupWidth(), fmd.getLookupHeight());
			// final LinkedHashMap<String, String> lhm = Utils.createStrSortedLinkedHashMap(ConstructorApp.staticLookupsArr.get(lookupCode),
			// !"8".equals(c.getFieldType()));
			// ((MyComboBoxItem) cmbxItem).setValueMap(lhm);
			((MyComboBoxItem) cmbxItem).setValueMap(lookupCode);
			this.setCellFormatter(new CellFormatter() {
				@Override
				public String format(Object value, ListGridRecord record, int rowNum, int colNum) {
					String result;
					try {
						// result = staticLookup.get(value);
						result = ((MyComboBoxItem) cmbxItem).getValueMap().get(value);
					} catch (Exception e) {
						result = e.toString();
					}
					return result;
				}
			});
			// mm20120125 По просьбе Акмарал - поиск внутри строки, а не только с начала ее.
			// TODO - вынести в свойство лукапа.
			cmbxItem.setTextMatchStyle(TextMatchStyle.SUBSTRING);

			this.setEditorProperties(cmbxItem);
		}
		// SQL Lookup
		else if ("Y".equals(c.getShowOnGrid()) && null != lookupCode && ("9".equals(c.getFieldType()))) {
			cmbxItem = new GridComboBoxItem(c, mainFormPane, this);
			// cbi.addChangedHandler(handler);
		}

		else if ("Y".equals(c.getShowOnGrid()) && "16".equals(c.getFieldType()) && null != lookupCode) {
			cmbxItem = new FormLookupComboboxItem(c, mainFormPane);
			this.setEditorProperties(cmbxItem);
		}

		// 20101005-Перенос из GridComboBoxItem CellFormatter для накрываемых полей. Пофиг, даже если не лукап
		final String lookupDisplValFld = columnMD.getLookupDisplayValue();
		if (null != lookupDisplValFld) {
			this.setCellFormatter(new CellFormatter() {
				@Override
				public String format(Object value, ListGridRecord record, int rowNum, int colNum) {
					// 20110625 - косяк с обновлением записи. Проверено, работает нормально
					String result = (null != value)
							? mainFormPane.getMainForm().getTreeGrid().getEditedRecord(rowNum).getAttribute(lookupDisplValFld) : null;
					// String result = (null != value) ? record.getAttribute(lookupDisplValFld) : null;
					return result;
				}
			});
		}
		/***************** Действия ***********************/
		for (int j = 0; j < c.getColActions().size(); j++) {
			final ColumnAction ca = c.getColActions().get(j);
			System.out.println("getColAction(" + j + "):" + ca);
			String actionType = ca.getColActionTypeCode();
			if ("1".equals(actionType)) {
				// TODO Отловить Enter
				// this.addChangedHandler(new ChangedHandler() {
				// @Override
				// public void onChanged(ChangedEvent event) {
				//
				// }
				// });
			}
			if ("2".equals(actionType)) {
				this.addEditorEnterHandler(new EditorEnterHandler() {
					@Override
					public void onEditorEnter(EditorEnterEvent event) {
						mainFormPane.getButtonsToolBar().actionItemsMap.get(ca.getActionCode()).doActionWithConfirm(event.getRowNum());
					}
				});
			}

			if ("3".equals(actionType)) {
				this.addEditorExitHandler(new EditorExitHandler() {
					@Override
					public void onEditorExit(EditorExitEvent event) {
						mainFormPane.getButtonsToolBar().actionItemsMap.get(ca.getActionCode()).doActionWithConfirm(event.getRowNum());
					}
				});
			}
			// TODO Убрать - см. MyComboBoxItem.doOnRecordSelectedAction
			if (1 == 2 && "4".equals(actionType) && null != cmbxItem && "9".equals(c.getFieldType())

			// ("8".equals(c.getFieldType()) || "9".equals(c.getFieldType()) || "10".equals(c.getFieldType()))
			) {
				this.addChangedHandler(new ChangedHandler() {
					@Override
					public void onChanged(ChangedEvent event) {
						try {
							// TODO пока не разрулилось различие между выбором из лукапа и
							// см. http://forums.smartclient.com/showthread.php?t=16067&highlight=ComboBoxItem+onChanged
							String keyVal = event.getValue() + "";
							String dispVal = event.getItem().getDisplayValue();
							if (!keyVal.equals(dispVal))
								mainFormPane.getButtonsToolBar().actionItemsMap.get(ca.getActionCode())
										.doActionWithConfirm(event.getRowNum());
						} catch (Exception e) {
							e.printStackTrace();
							Utils.debug(e.getMessage());
						}
					}
				});
			}
		}
	}

	/**
	 * @return the colNum
	 */
	public int getColNum() {
		return colNum;
	}

	/**
	 * @return the column
	 */
	public FormColumnMD getColumnMD() {
		return columnMD;
	}

	/**
	 * @return the mainFormPane
	 */
	public MainFormPane getMainFormPane() {
		return mainFormPane;
	}

	/**
	 * @param colNum
	 *            the colNum to set
	 */
	public void setColNum(int colNum) {
		this.colNum = colNum;
	}

	/**
	 * @param columnMD
	 *            the column to set
	 */
	public void setColumnMD(FormColumnMD columnMD) {
		this.columnMD = columnMD;
	}

	/**
	 * @param mainFormPane
	 *            the mainFormPane to set
	 */
	public void setMainFormPane(MainFormPane mainFormPane) {
		this.mainFormPane = mainFormPane;
	}

	public void setGridComboBoxItem(GridComboBoxItem gridComboBoxItem) {
		this.gridComboBoxItem = gridComboBoxItem;
	}

	public GridComboBoxItem getGridComboBoxItem() {
		return gridComboBoxItem;
	}
}
