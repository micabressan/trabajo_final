<?php

namespace Swivl\UserBundle\Validator\Constraints;

use Symfony\Component\Validator\Constraint;
use Symfony\Component\Validator\ConstraintValidator;

/**
 * Class BlackListValidator
 *
 * @package Swivl\UserBundle\Validator\Constraints
 */
class BlackListValidator extends ConstraintValidator
{
    /**
     * @var array
     */
    public $list;

    /**
     * Validating black list
     *
     * @param mixed      $value
     * @param Constraint $constraint
     */
    public function validate($value, Constraint $constraint)
    {
        if (in_array(substr($value, strpos($value, '@') + 1), $this->list)) {
            $this->context
                ->buildViolation($constraint->message)
                ->addViolation()
            ;
        }
    }
}