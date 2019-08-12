class AddTriggerToTargetLimitCountByUser < ActiveRecord::Migration[5.2]
  def up
    execute <<-SQL
      CREATE OR REPLACE FUNCTION validate_target_limit_by_user() RETURNS trigger AS $validate_target_limit_by_user$
        DECLARE
          count_targets integer;
        BEGIN
          count_targets :=  (SELECT COUNT(t.*) FROM targets t WHERE NEW.user_id = t.user_id);

          IF count_targets >= #{Target::MAX_TARGETS_PER_USER} THEN
              RAISE EXCEPTION '#{I18n.t('model.targets.name')} #{I18n.t('model.targets.errors.to_many')}';
          END IF;

          RETURN NEW;
      END;
      $validate_target_limit_by_user$ LANGUAGE plpgsql;

      DROP TRIGGER IF EXISTS trx_validate_target_limit_by_user ON targets;
      CREATE TRIGGER trx_validate_target_limit_by_user
        BEFORE INSERT OR UPDATE OF user_id ON targets
        FOR EACH ROW EXECUTE PROCEDURE validate_target_limit_by_user();
    SQL
  end

  def down
    execute <<-SQL
      DROP TRIGGER IF EXISTS trx_validate_target_limit_by_user ON targets;
      DROP FUNCTION IF EXISTS  validate_target_limit_by_user();
    SQL
  end
end
