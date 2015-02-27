class Document < NSDocument
  extend IB

  attr_accessor :employees

  outlet :table, NSTableView
  outlet :delete_btn, NSButton

  def insert_person(sender)
    mutableArrayValueForKey('employees').insertObject(Person.new, atIndex: @employees.size)
  end

  def remove_person(sender)
    mutableArrayValueForKey('employees').removeObjectAtIndex(@table.selectedRow)
  end

  def insertObject(p, inEmployeesAtIndex: idx)
    undoManager.prepareWithInvocationTarget(self).removeObjectFromEmployeesAtIndex(idx)
    unless undoManager.undoing?
      undoManager.actionName = 'Insert'
    end

    p.addObserver(self, forKeyPath: 'person_name', options: NSKeyValueObservingOptionOld, context: nil)
    p.addObserver(self, forKeyPath: 'expected_raise', options: NSKeyValueObservingOptionOld, context: nil)

    @employees << p
    @table.reloadData
  end

  def removeObjectFromEmployeesAtIndex(idx)
    p = @employees[idx]
    undoManager.prepareWithInvocationTarget(self).insertObject(p, inEmployeesAtIndex: idx) 
    unless undoManager.undoing?
      undoManager.actionName = 'Remove'
    end

    p.removeObserver(self, forKeyPath: 'person_name')
    p.removeObserver(self, forKeyPath: 'expected_raise')
    @employees.delete_at(idx)
    @table.reloadData
  end

  def observeValueForKeyPath(kp, ofObject: obj, change: chg, context: cnt)
    undoManager.prepareWithInvocationTarget(self).changeValueOfKeyPath(kp, ofObject: obj, to: chg[NSKeyValueChangeOldKey]) 
    unless undoManager.undoing?
      undoManager.actionName = 'Edit'
    end
  end

  def changeValueOfKeyPath(kp, ofObject: obj, to: v)
    obj.setValue(v, forKey: kp)
    @table.reloadData
  end

  def numberOfRowsInTableView(table)
    @employees.size
  end

  def tableView(table, objectValueForTableColumn: c, row: r)
    @employees[r].valueForKey(c.identifier)
  end

  def tableView(table, setObjectValue: v, forTableColumn: c, row: r)
    @employees[r].setValue(v, forKey: c.identifier)
  end

  def tableViewSelectionDidChange(nt)
    if -1 == @table.selectedRow
      @delete_btn.enabled = false
    else
      @delete_btn.enabled = true
    end
  end

  class << self
    def autosavesInPlace
      true
    end
  end

  def windowControllerDidLoadNib(aController)
    super
    @employees = []
    @table.delegate = self
    @table.dataSource = self
    @delete_btn.enabled = false
  end

  def windowNibName
    # Override returning the nib file name of the document
    # If you need to use a subclass of NSWindowController or if your document supports multiple NSWindowControllers, you should remove this method and override -makeWindowControllers instead.
    "Document"
  end

  def dataOfType(typeName, error: outError)
    # Insert code here to write your document to data of the specified type. If outError != NULL, ensure that you create and set an appropriate error when returning nil.
    # You can also choose to override -fileWrapperOfType:error:, -writeToURL:ofType:error:, or -writeToURL:ofType:forSaveOperation:originalContentsURL:error: instead.
    nil
  end

  def readFromData(data, ofType: typeName, error: outError)
    # Insert code here to read your document from the given data of the specified type. If outError != NULL, ensure that you create and set an appropriate error when returning NO.
    # You can also choose to override -readFromFileWrapper:ofType:error: or -readFromURL:ofType:error: instead.
    # If you override either of these, you should also override -isEntireFileLoaded to return NO if the contents are lazily loaded.
    true
  end
end
