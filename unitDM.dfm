object dm: Tdm
  OnCreate = DataModuleCreate
  Height = 330
  Width = 578
  PixelsPerInch = 96
  object FDConnection: TFDConnection
    Params.Strings = (
      'DriverID=SQLite'
      'Database=E:\ABC\abc.db')
    Left = 168
    Top = 16
  end
  object DataSource: TDataSource
    DataSet = FDTable
    Left = 272
    Top = 16
  end
  object FDTable: TFDTable
    IndexFieldNames = 'sequencia'
    Connection = FDConnection
    TableName = 'abastecimentos'
    Left = 304
    Top = 88
    object FDTablesequencia: TFDAutoIncField
      FieldName = 'sequencia'
      Origin = 'sequencia'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object FDTabledata: TDateTimeField
      FieldName = 'data'
      Origin = 'data'
    end
    object FDTabletanque: TIntegerField
      FieldName = 'tanque'
      Origin = 'tanque'
    end
    object FDTablebomba: TIntegerField
      FieldName = 'bomba'
      Origin = 'bomba'
    end
    object FDTablelitros: TFloatField
      FieldName = 'litros'
      Origin = 'litros'
    end
    object FDTablevalor: TFloatField
      FieldName = 'valor'
      Origin = 'valor'
    end
  end
  object FDQuery: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      'select strftime('#39'%Y/%m/%d'#39', data) as data,'
      
        '(case when tanque = 1 then "GASOLINA" else "DIESEL" end) as tanq' +
        'ue,'
      
        ' bomba, sum(litros) as litros, sum(valor) as valor, (imposto * s' +
        'um(valor) / 100) as imposto'
      'from abastecimentos'
      'group by strftime('#39'%Y/%m/%d'#39', data), tanque, bomba')
    Left = 136
    Top = 112
    object FDQuerydata: TWideStringField
      AutoGenerateValue = arDefault
      FieldName = 'data'
      Origin = 'data'
      ProviderFlags = []
      ReadOnly = True
      Size = 32767
    end
    object FDQuerytanque: TWideStringField
      AutoGenerateValue = arDefault
      FieldName = 'tanque'
      Origin = 'tanque'
      ProviderFlags = []
      ReadOnly = True
      Size = 32767
    end
    object FDQuerybomba: TIntegerField
      FieldName = 'bomba'
      Origin = 'bomba'
    end
    object FDQuerylitros: TFloatField
      FieldName = 'litros'
      Origin = 'litros'
    end
    object FDQueryvalor: TFloatField
      FieldName = 'valor'
      Origin = 'valor'
    end
    object FDQueryimposto: TFloatField
      FieldName = 'imposto'
      Origin = 'imposto'
    end
  end
end
