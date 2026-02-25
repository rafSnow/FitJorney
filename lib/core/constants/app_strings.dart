/// Todas as strings visíveis para o usuário.
/// Centralizadas para futura internacionalização.
class AppStrings {
  AppStrings._();

  // App
  static const appName = 'FitJourney';

  // Navegação
  static const home = 'Início';
  static const exercises = 'Exercícios';
  static const programs = 'Programas';
  static const history = 'Histórico';
  static const progress = 'Progresso';

  // Ações gerais
  static const save = 'Salvar';
  static const cancel = 'Cancelar';
  static const delete = 'Excluir';
  static const edit = 'Editar';
  static const confirm = 'Confirmar';
  static const add = 'Adicionar';
  static const search = 'Buscar';
  static const close = 'Fechar';

  // Exercícios
  static const newExercise = 'Novo Exercício';
  static const editExercise = 'Editar Exercício';
  static const exerciseName = 'Nome do exercício';
  static const muscleGroup = 'Grupo muscular';
  static const muscleSize = 'Tamanho do músculo';
  static const muscleLarge = 'Grande';
  static const muscleSmall = 'Pequeno';
  static const exerciseType = 'Tipo de exercício';
  static const compound = 'Composto';
  static const isolation = 'Isolado';
  static const metricType = 'Tipo de métrica';
  static const loadKg = 'Carga (kg)';
  static const timeSeconds = 'Tempo (seg)';
  static const youtubeUrl = 'URL do YouTube';
  static const suggestedIncrement = 'Incremento sugerido';
  static const customIncrement = 'Incremento personalizado';
  static const noExercises = 'Nenhum exercício cadastrado';
  static const noExercisesCta = 'Comece adicionando seu primeiro exercício';
  static const deleteExerciseTitle = 'Excluir exercício?';
  static const deleteExerciseMessage =
      'Esta ação não pode ser desfeita. O exercício será removido permanentemente.';

  // Programas
  static const newProgram = 'Novo Programa';
  static const editProgram = 'Editar Programa';
  static const programName = 'Nome do programa';
  static const activeProgram = 'Programa ativo';
  static const activate = 'Ativar Programa';
  static const programActivated = '\u00e9 o programa ativo agora!';
  static const noPrograms = 'Nenhum programa criado';
  static const noProgramsCta = 'Crie seu primeiro programa de treino';
  static const selectExercise = 'Selecionar Exerc\u00edcio';
  static const configureExercise = 'Configurar Exerc\u00edcio';
  static const deleteProgramTitle = 'Excluir programa?';
  static const deleteProgramMessage =
      'Esta a\u00e7\u00e3o n\u00e3o pode ser desfeita. Todo o hist\u00f3rico deste programa ser\u00e1 preservado nas sess\u00f5es registradas.';
  static const sets = 'Séries';
  static const reps = 'Repetições';
  static const repRange = 'Range de reps';
  static const rpeTarget = 'RPE alvo';
  static const restTime = 'Descanso';

  // Sessão de treino
  static const startWorkout = 'Treinar';
  static const nextWorkout = 'Próximo treino';
  static const confirmSet = 'Confirmar Série';
  static const skipSet = 'Pular';
  static const addExtraSet = 'Série extra';
  static const finishWorkout = 'Finalizar Treino';
  static const workoutSummary = 'Resumo do Treino';
  static const noActiveProgram = 'Nenhum programa ativo';
  static const noActiveProgramCta = 'Ative um programa para começar a treinar';
  static const load = 'Carga';
  static const repsCompleted = 'Reps';
  static const rpeAchieved = 'RPE';
  static const setNumber = 'Série';

  // Progressão
  static const progressionDetected = 'Hora de progredir!';
  static const progressionMessage =
      'Você atingiu o máximo em todas as séries! Hora de aumentar a carga.';
  static const regressionDetected = 'Considere reduzir a carga';
  static const regressionMessage =
      'Carga muito alta por 2 sessões. Considere reduzir.';
  static const suggestedLoad = 'Carga sugerida';
  static const currentLoad = 'Carga atual';

  // Cronômetro
  static const restTimer = 'Descanso';
  static const restFinished = 'Descanso concluído';
  static const restTimerNotification = 'Cronômetro de descanso';

  // Histórico
  static const noHistory = 'Nenhuma sessão registrada';
  static const noHistoryCta = 'Suas sessões de treino aparecerão aqui';
  static const duration = 'Duração';
  static const sessionDetail = 'Detalhes da Sessão';
  static const filterAll = 'Todos';
  static const filterWeek = 'Semana';
  static const filterMonth = 'Mês';
  static const progressionAchieved = 'Progressão atingida';
  static const noSetsRecorded = 'Nenhuma série registrada';
  static const repRangeLabel = 'reps';
  static const setsCompleted = 'séries';

  // Progresso / Gráficos
  static const noProgress = 'Dados insuficientes';
  static const noProgressCta = 'Treine mais para ver sua evolução';
  static const weeklyStreak = 'Frequência semanal';
  static const loadEvolution = 'Evolução de carga';

  // Erros
  static const genericError = 'Algo deu errado. Tente novamente.';
  static const fieldRequired = 'Este campo é obrigatório';
  static const cannotDeleteActiveProgram =
      'Não é possível excluir: este exercício está em um programa ativo.';

  // Grupos musculares
  static const chest = 'Peito';
  static const back = 'Costas';
  static const shoulders = 'Ombros';
  static const biceps = 'Bíceps';
  static const triceps = 'Tríceps';
  static const forearm = 'Antebraço';
  static const quadriceps = 'Quadríceps';
  static const hamstrings = 'Posterior de Coxa';
  static const glutes = 'Glúteos';
  static const calves = 'Panturrilha';
  static const core = 'Core';
  static const fullBody = 'Full Body';
}
