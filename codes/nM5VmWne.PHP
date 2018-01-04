<?php
/**
 * Espelho Listing
 * @author  <your name here>
 */
class Espelho extends TPage
{
    private $form; // form
    private $datagrid; // listing
    private $pageNavigation;
    private $formgrid;
    private $loaded;
    private $deleteButton;
   // private static $database = 'bluemob';
    private static $activeRecord = 'Espelho';
    private static $primaryKey = 'CHAPA';
    private static $formName = 'form_Espelho';

    /**
     * Class constructor
     * Creates the page, the form and the listing
     */
    public function __construct()
    {
        parent::__construct();

        // creates the form
        $this->form = new BootstrapFormBuilder(self::$formName);

        // define the form title
        $this->form->setFormTitle('Título do formulário');

        $CHAPA = new TDBCombo('CHAPA', 'bluemob', 'Pfunc', 'CHAPA', '{CHAPA}','CHAPA asc'  );
        $CODCOLIGADA = new TEntry('CODCOLIGADA');
        $NOME = new TEntry('NOME');
        $CODSECAO = new TEntry('CODSECAO');
        $DATA = new TDate('DATA');
        $FUNCAO = new TEntry('FUNCAO');

        $DATA1->setMask('dd/mm/yyyy');
        $DATA1->setDatabaseMask('yyyy-mm-dd');
        $CHAPA->setSize(202);
        $DATA->setSize(250);
        $NOME->setSize('50%');
        $FUNCAO->setSize('50%');
        $CODSECAO->setSize('22%');
        $CODCOLIGADA->setSize('20%');


        $this->form->addFields([new TLabel('CHAPA:')],[$CHAPA,new TLabel('CODCOLIGADA:'),$CODCOLIGADA]);
        $this->form->addFields([new TLabel('NOME:')],[$NOME]);
        $this->form->addFields([new TLabel('CODSECAO:')],[$CODSECAO,new TLabel('DATA:'),$DATA]);
        $this->form->addFields([new TLabel('FUNCAO:')],[$FUNCAO]);

        // keep the form filled during navigation with session data
        $this->form->setData( TSession::getValue(__CLASS__.'_filter_data') );

        $btn_onsearch = $this->form->addAction('Buscar', new TAction([$this, 'onSearch']), 'fa:search #ffffff');
        $btn_onsearch->addStyleClass('btn-primary'); 

        // creates a Datagrid
        $this->datagrid = new TDataGrid;
        $this->datagrid = new BootstrapDatagridWrapper($this->datagrid);

        $this->datagrid->style = 'width: 100%';
        $this->datagrid->setHeight(320);

        $this->datagrid->datatable = 'true';

        $column_CHAPA = new TDataGridColumn('CHAPA', 'CHAPA', 'center' , '70px');
        $column_CODCOLIGADA = new TDataGridColumn('CODCOLIGADA', 'CODCOLIGADA', 'left');
        $column_NOME = new TDataGridColumn('NOME', 'NOME', 'left');
        $column_DATA = new TDataGridColumn('DATA', 'DATA1', 'left');
        $column_BATIDA1 = new TDataGridColumn('BATIDA1', 'BATIDA1', 'left');
        $column_BATIDA2 = new TDataGridColumn('BATIDA2', 'BATIDA2', 'left');
        $column_BATIDA3 = new TDataGridColumn('BATIDA3', 'BATIDA3', 'left');
        $column_BATIDA4 = new TDataGridColumn('BATIDA4', 'BATIDA4', 'left');
        $column_BATIDA5 = new TDataGridColumn('BATIDA5', 'BATIDA5', 'left');
        $column_BATIDA6 = new TDataGridColumn('BATIDA6', 'BATIDA6', 'left');

        $order_CHAPA = new TAction(array($this, 'onReload'));
        $order_CHAPA->setParameter('order', 'CHAPA');
        $column_CHAPA->setAction($order_CHAPA);

        $this->datagrid->addColumn($column_CHAPA);
        $this->datagrid->addColumn($column_CODCOLIGADA);
        $this->datagrid->addColumn($column_NOME);
        $this->datagrid->addColumn($column_DATA);
        $this->datagrid->addColumn($column_BATIDA1);
        $this->datagrid->addColumn($column_BATIDA2);
        $this->datagrid->addColumn($column_BATIDA3);
        $this->datagrid->addColumn($column_BATIDA4);
        $this->datagrid->addColumn($column_BATIDA5);
        $this->datagrid->addColumn($column_BATIDA6);

        $action_onDelete = new TDataGridAction(array('Espelho', 'onDelete'));
        $action_onDelete->setUseButton(false);
        $action_onDelete->setButtonClass('btn btn-default btn-sm');
        $action_onDelete->setLabel('Excluir');
        $action_onDelete->setImage('fa:trash-o #dd5a43');
        $action_onDelete->setField(self::$primaryKey);

        $this->datagrid->addAction($action_onDelete);

        // create the datagrid model
        $this->datagrid->createModel();

        // creates the page navigation
        $this->pageNavigation = new TPageNavigation;
        $this->pageNavigation->setAction(new TAction(array($this, 'onReload')));
        $this->pageNavigation->setWidth($this->datagrid->getWidth());

        $panel = new TPanelGroup;
        $panel->add($this->datagrid);

        $panel->addFooter($this->pageNavigation);

        // vertical box container
        $container = new TVBox;
        $container->style = 'width: 100%';
        // $container->add(new TXMLBreadCrumb('menu.xml', __CLASS__));
        $container->add($this->form);
        $container->add($panel);

        parent::add($container);
    }

    public function onDelete($param = null) 
    { 
        if(isset($param['delete']) && $param['delete'] == 1)
        {
            try
            {
                // get the paramseter $key
                $key = $param['key'];
                // open a transaction with database
                TTransaction::open('bluemob');

                // instantiates object
                $object = new Espelho($key, FALSE); 

                // deletes the object from the database
                $object->delete();

                // close the transaction
                TTransaction::close();

                // reload the listing
                $this->onReload( $param );
                // shows the success message
                new TMessage('info', AdiantiCoreTranslator::translate('Record deleted'));
            }
            catch (Exception $e) // in case of exception
            {
                // shows the exception error message
                new TMessage('error', $e->getMessage());
                // undo all pending operations
                TTransaction::rollback();
            }
        }
        else
        {
            // define the delete action
            $action = new TAction(array($this, 'onDelete'));
            $action->setParameters($param); // pass the key paramseter ahead
            $action->setParameter('delete', 1);
            // shows a dialog to the user
            new TQuestion(AdiantiCoreTranslator::translate('Do you really want to delete ?'), $action);   
        }
    }

    /**
     * Register the filter in the session
     */
    public function onSearch()
    {
        // get the search form data
        $data = $this->form->getData();
        $filters = [];

        TSession::setValue(__CLASS__.'_filter_data', NULL);
        TSession::setValue(__CLASS__.'_filters', NULL);

        if (isset($data->CHAPA) AND ($data->CHAPA)) 
        {
            $filters[] = new TFilter('CHAPA', '=', $data->CHAPA);// create the filter 
        }
        if (isset($data->CODCOLIGADA) AND ($data->CODCOLIGADA)) 
        {
            $filters[] = new TFilter('CODCOLIGADA', '=', $data->CODCOLIGADA);// create the filter 
        }
        if (isset($data->NOME) AND ($data->NOME)) 
        {
            $filters[] = new TFilter('NOME', 'like', "%{$data->NOME}%");// create the filter 
        }
        if (isset($data->CODSECAO) AND ($data->CODSECAO)) 
        {
            $filters[] = new TFilter('CODSECAO', 'like', "%{$data->CODSECAO}%");// create the filter 
        }
        if (isset($data->DATA1) AND ($data->DATA1)) 
        {
            $filters[] = new TFilter('DATA', '=', $data->DATA);// create the filter 
        }
        if (isset($data->FUNCAO) AND ($data->FUNCAO)) 
        {
            $filters[] = new TFilter('FUNCAO', 'like', "%{$data->FUNCAO}%");// create the filter 
        }

        // fill the form with data again
        $this->form->setData($data);

        // keep the search data in the session
        TSession::setValue(__CLASS__.'_filter_data', $data);
        TSession::setValue(__CLASS__.'_filters', $filters);

        $param=array();
        $param['offset']    =0;
        $param['first_page']=1;
        $this->onReload($param);
    }

    /**
     * Load the datagrid with data
     */
    public function onReload($param = NULL)
    {
        try
        {
            // open a transaction with database 'bluemob'
            TTransaction::open('bluemob');

            // creates a repository for Espelho
            $repository = new TRepository('Espelho');
            $limit = 30;
            // creates a criteria
            $criteria = new TCriteria;

            if (empty($param['order']))
            {
                $param['order'] = 'DATA';    
            }

            if (empty($param['direction']))
            {
                $param['direction'] = 'desc';
            }

            $criteria->setProperties($param); // order, offset
            $criteria->setProperty('limit', $limit);

            if($filters = TSession::getValue(__CLASS__.'_filters'))
            {
                foreach ($filters as $filter) 
                {
                    $criteria->add($filter);       
                }
            }

            // load the objects according to criteria
            $objects = $repository->load($criteria, FALSE);

            $this->datagrid->clear();
            if ($objects)
            {
                // iterate the collection of active records
                foreach ($objects as $object)
                {
                    // add the object inside the datagrid
                    $this->datagrid->addItem($object);
                }
            }

            // reset the criteria for record count
            $criteria->resetProperties();
            $count= $repository->count($criteria);

            $this->pageNavigation->setCount($count); // count of records
            $this->pageNavigation->setProperties($param); // order, page
            $this->pageNavigation->setLimit($limit); // limit

            // close the transaction
            TTransaction::close();
            $this->loaded = true;
        }
        catch (Exception $e) // in case of exception
        {
            // shows the exception error message
            new TMessage('error', $e->getMessage());
            // undo all pending operations
            TTransaction::rollback();
        }
    }

    public function onShow()
    {

    }

    /**
     * method show()
     * Shows the page
     */
    public function show()
    {
        // check if the datagrid is already loaded
        if (!$this->loaded AND (!isset($_GET['method']) OR !(in_array($_GET['method'],  array('onReload', 'onSearch')))) )
        {
            if (func_num_args() > 0)
            {
                $this->onReload( func_get_arg(0) );
            }
            else
            {
                $this->onReload();
            }
        }
        parent::show();
    }
}